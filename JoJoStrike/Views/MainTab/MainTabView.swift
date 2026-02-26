import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState

        TabView(selection: $state.selectedTab) {
            Tab("Entrenar", systemImage: "figure.martial.arts", value: .training) {
                TrainingView()
            }

            Tab("Tienda", systemImage: "bag.fill", value: .shop) {
                ShopView()
            }

            Tab("Colección", systemImage: "rectangle.stack.fill", value: .collection) {
                CollectibleCollectionView()
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
