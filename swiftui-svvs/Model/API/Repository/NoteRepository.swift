import Foundation

protocol NoteRepositoryProtocol: Sendable {
    func getNote(_ userId: String) async throws -> Note
}

struct NoteRepository: NoteRepositoryProtocol {

    func getNote(_ userId: String) async throws -> Note {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1秒待つ
        return Note(updateAt: "yyyymmddhhmmss", items: [NoteContent(id: "a", content: "新着情報")])
    }
}
