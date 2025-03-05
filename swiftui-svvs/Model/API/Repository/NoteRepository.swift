import Foundation

protocol NoteRepositoryProtocol: Sendable {
    
    /// ノートデータの取得
    /// - Parameter userId: ユーザーID
    /// - Returns: ノートデータ
    func getNote(_ userId: String) async throws -> Note
}

struct NoteRepository: NoteRepositoryProtocol {

    func getNote(_ userId: String) async throws -> Note {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1秒待つ
        return Note(updateAt: "yyyymmddhhmmss", contents: [NoteContent(id: "a", content: "新着情報")])
    }
}
