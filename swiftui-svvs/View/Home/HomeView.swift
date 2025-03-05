import SwiftUI

struct HomeView: View {
    @StateObject private var state: HomeViewState

    init(state: HomeViewState = HomeViewState()) {
        self._state = .init(wrappedValue: state)
    }

    var body: some View {
        VStack {
            Text(self.state.userGreeting)
            
            Button(action: {
                Task {
                    await self.state.didTapNoteButton()
                }
            }, label: {
                Text("ノート画面を表示")
            })
        }
        .navigationTitle("Home")
        .navigationDestination(isPresented: self.$state.shouldNavigateNote) {
            NoteView()
        }
        .task {
            Task {
                await self.state.didAppear()
            }
        }
    }
}
