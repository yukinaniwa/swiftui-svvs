import Combine
import Foundation

@MainActor
protocol NoteViewStateProtocol: ObservableObject {
    var apiState: APIFetchState { get }
    var showingModal: Bool { get set }
    
    func didTapGetNoteButton() async
    func didAppear() async
    
    func didTapModalButton() async
}

@MainActor
class NoteViewState: NoteViewStateProtocol {
    private let userStore: any UserStoreProtocol
    private let store: any NoteStoreProtocol
    
    @Published var apiState: APIFetchState = .none
    
    @Published var showingModal: Bool = false
    
    private var cancellables = Set<AnyCancellable>()

    init(userStore: any UserStoreProtocol = UserStore.shared) {
        self.userStore = userStore
        self.store = NoteStore()
        self.setupStoreBindings()
    }

    /// Storeプロパティ購読を設定する
    func setupStoreBindings() {
        self.store.notePublisher
            .sink { [weak self] note in
                if note != nil {
                    self?.apiState = .success
                }
            }
            .store(in: &cancellables)
        self.store.errorPublisher
            .sink { [weak self] error in
                // 実際はエラーハンドリングを行う
                if error != nil {
                    self?.apiState = .failure
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Life Cycle

extension NoteViewState {
    /// 画面が表示された
    func didAppear() async {
        self.apiState = .none
    }
}

// MARK: - Actions

extension NoteViewState {
    
    /// モーダルを表示
    func didTapModalButton() async {
        showingModal.toggle()
    }
    
    /// ノートデータの取得するボタンが押下された
    func didTapGetNoteButton() async {
        if let id = await userStore.getID() {
            self.apiState = .loading
            await self.store.getNote(id)
        }
    }

}
