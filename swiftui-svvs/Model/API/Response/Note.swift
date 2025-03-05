struct Note: Decodable {
    let updateAt: String
    let items: [NoteContent]
}

struct NoteContent: Decodable {
    let id: String
    let content: String
}
