import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState

        TabView(selection: $state.selectedTab) {
            Tab("Descubrir", systemImage: "rectangle.stack.fill", value: .discover) {
                CardSwipeView()
            }

            Tab("Colección", systemImage: "square.grid.2x2.fill", value: .collection) {
                CollectionView()
            }

            Tab("Perfil", systemImage: "person.fill", value: .profile) {
                ProfileView()
            }
        }
        .tint(.jojoGold)
    }
}

#Preview {
    MainTabView()
        .environment(AppState())
}
