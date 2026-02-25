import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState

        TabView(selection: $state.selectedTab) {
            Tab("Discover", systemImage: "rectangle.stack.fill", value: .discover) {
                CardSwipeView()
            }

            Tab("Collection", systemImage: "square.grid.2x2.fill", value: .collection) {
                CollectionView()
            }

            Tab("Profile", systemImage: "person.fill", value: .profile) {
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
