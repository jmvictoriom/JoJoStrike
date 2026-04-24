import SwiftUI

struct JJAppBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                .jojoDarkBg,
                Color.jojoPurple.opacity(0.22),
                .jojoDarkBg
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay {
            RadialGradient(
                colors: [Color.jojoGold.opacity(0.14), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 380
            )
        }
        .ignoresSafeArea()
    }
}
