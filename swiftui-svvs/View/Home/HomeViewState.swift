import Combine
import Foundation

@MainActor
protocol HomeViewStateProtocol: ObservableObject {
    var shouldNavigateNote: Bool { get set }

    func didTapNoteButton() async
    func didAppear() async
}

@MainActor
class HomeViewState: HomeViewStateProtocol {
    private let store: any UserStoreProtocol
    @Published var user: User?
    
    @Published var shouldNavigateNote: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init(store: any UserStoreProtocol = UserStore.shared) {
        self.store = store
        self.setupStoreBindings()
    }

    /// Storeプロパティ購読を設定する
    func setupStoreBindings() {
        self.store.userPublisher
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}

extension HomeViewState {
    /// ユーザ名付きの挨拶文字列
    var userGreeting: String {
        guard let user else { return "名前が取得できません" }
        return "こんにちは \(user.name)さん"
    }
}

// MARK: - Life Cycle

extension HomeViewState {
    /// 画面が表示された
    func didAppear() async {
        self.shouldNavigateNote = false
    }
}

// MARK: - Actions

extension HomeViewState {
    ///ノート表示ボタンが押下された
    func didTapNoteButton() async {
        self.shouldNavigateNote = true
    }
}
