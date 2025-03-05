import Combine

@MainActor
protocol NoteStoreProtocol: ObservableObject {
    var notePublisher: Published<Note?>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    
    func getNote(_ userId: String) async
}

@MainActor
class NoteStore: ObservableObject, NoteStoreProtocol {
    let noteRepository: NoteRepositoryProtocol

    @Published var note: Note?
    @Published var error: Error?
    
    // プロトコルに準拠するためのPublisher
    var notePublisher: Published<Note?>.Publisher { $note }
    var errorPublisher: Published<Error?>.Publisher { $error }

    init(_ repository: NoteRepositoryProtocol = NoteRepository()) {
        self.noteRepository = repository
    }

    func getNote(_ userId: String) async {
        self.error = nil
        do {
            self.note = try await self.noteRepository.getNote(userId)
        } catch {
            await MainActor.run {
                self.note = nil
                self.error = error
            }
        }
    }
}
