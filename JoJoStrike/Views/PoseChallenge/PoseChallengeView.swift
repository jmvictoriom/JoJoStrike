import SwiftUI

struct PoseChallengeView: View {
    let poseID: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.jojoDarkBg
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "camera.viewfinder")
                    .font(.system(size: 80))
                    .foregroundStyle(.jojoRed)

                Text("POSE CHALLENGE")
                    .font(.system(size: 28, weight: .black))
                    .foregroundStyle(.jojoRed)
                    .tracking(4)

                Text("Camera detection coming soon")
                    .foregroundStyle(.secondary)

                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.jojoGold)
            }
        }
    }
}

#Preview {
    PoseChallengeView(poseID: "preview")
}
