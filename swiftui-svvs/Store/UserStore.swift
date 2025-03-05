import Combine

@MainActor
protocol UserStoreProtocol: ObservableObject {
    var userPublisher: Published<User?>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    func login(_ userId: String, _ password: String) async
    func getID() async -> String?
}

@MainActor
class UserStore: ObservableObject, UserStoreProtocol {
    static var shared = UserStore()

    let loginRepository: LoginRepositoryProtocol

    @Published var user: User?
    @Published var error: Error?
    // プロトコルに準拠するためのPublisher
    var userPublisher: Published<User?>.Publisher { $user }
    var errorPublisher: Published<Error?>.Publisher { $error }

    init(_ repository: LoginRepositoryProtocol = LoginRepository()) {
        self.loginRepository = repository
    }

    func login(_ userId: String, _ password: String) async {
        self.error = nil
        do {
            self.user = try await self.loginRepository.login(userId, password)
        } catch {
            await MainActor.run {
                self.user = nil
                self.error = error
            }
        }
    }
    
    func getID() async -> String? {
        self.user?.id
    }
}
