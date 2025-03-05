import SwiftUI

struct NoteView<State: NoteViewStateProtocol & ObservableObject>: View {
    @StateObject private var state: State
    
    init(state: State = NoteViewState()) {
        self._state = StateObject(wrappedValue: state)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Button(action: {
                    Task {
                        await self.state.didTapGetNoteButton()
                    }
                }, label: {
                    Text("ノート画面")
                })
                
                
                Group {
                    if self.state.apiState == .success {
                        Button(action: {
                            Task {
                                await self.state.didTapModalButton()
                            }
                        }, label: {
                            Text("ノート読み込み完了")
                        })
                        .sheet(isPresented: self.$state.showingModal) {
                            Text("modal")
                        }
                    } else if self.state.apiState == .failure {
                        Text("ノートの取得に失敗しました")
                    } else if self.state.apiState == .loading {
                        ProgressView("読み込み中..")
                    } else if self.state.apiState == .none {
                        EmptyView()
                    }
                }
            }
            .padding()
            .navigationTitle("Note")
            .task {
                Task {
                    await self.state.didAppear()
                }
            }
        }
    }
}
