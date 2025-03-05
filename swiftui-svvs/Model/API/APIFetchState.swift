/// API 通信状態
enum APIFetchState {
    /// 何もしていない
    case none
    /// 読み込み中
    case loading
    /// 読み込み完了
    case success
    /// 読み込み失敗
    case failure
}
