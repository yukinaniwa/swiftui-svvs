/// ノートデータ
struct Note: Decodable {
    let updateAt: String /// 更新日時
    let contents: [NoteContent] /// ノート情報
}

struct NoteContent: Decodable {
    let id: String
    let content: String
}
