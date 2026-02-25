import SwiftUI

struct CardSwipeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("ゴゴゴ")
                        .font(.system(size: 40))
                        .foregroundStyle(.jojoGold.opacity(0.3))

                    Text("DISCOVER")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.jojoGold)
                        .tracking(6)

                    Text("Swipe cards coming soon")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("JoJo Strike")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    CardSwipeView()
}
