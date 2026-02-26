import SwiftUI

struct PoseResultView: View {
    let poseName: String
    let score: Int
    let medal: Medal
    let xpEarned: Int
    let coinsEarned: Int
    let onDismiss: () -> Void

    @State private var showScore = false
    @State private var showMedal = false
    @State private var showXP = false
    @State private var showCoins = false

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                // Pose name
                Text(poseName)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                // Score
                if showScore {
                    Text("\(score)")
                        .font(.system(size: 80, weight: .black, design: .rounded))
                        .foregroundStyle(medal.color)
                        .transition(.scale.combined(with: .opacity))
                }

                // Medal
                if showMedal {
                    VStack(spacing: 8) {
                        Text(medal.emoji)
                            .font(.system(size: 60))

                        Text(medal.displayName)
                            .font(.title.bold())
                            .foregroundStyle(medal.color)
                            .tracking(4)
                    }
                    .transition(.scale.combined(with: .opacity))
                }

                // XP earned
                if showXP {
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundStyle(.jojoGold)
                        Text("+\(xpEarned) XP")
                            .font(.title3.bold())
                            .foregroundStyle(.jojoGold)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Coins earned
                if showCoins && coinsEarned > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundStyle(.jojoGold)
                        Text("+\(coinsEarned) monedas")
                            .font(.title3.bold())
                            .foregroundStyle(.jojoGold)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                Spacer()

                // Actions
                VStack(spacing: 12) {
                    Button(action: onDismiss) {
                        Text("CONTINUAR")
                            .font(.headline.bold())
                            .tracking(2)
                            .foregroundStyle(.jojoDarkBg)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.jojoGold.gradient)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .onAppear { runAnimationSequence() }
    }

    private func runAnimationSequence() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.3)) {
            showScore = true
        }
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.8)) {
            showMedal = true
        }
        withAnimation(.spring(response: 0.4).delay(1.2)) {
            showXP = true
        }
        withAnimation(.spring(response: 0.4).delay(1.5)) {
            showCoins = true
        }
        if medal >= .gold {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                HapticsService.achievement()
            }
        }
    }
}

#Preview {
    PoseResultView(
        poseName: "DIO's WRYYY Arch",
        score: 87,
        medal: .gold,
        xpEarned: 420,
        coinsEarned: 40,
        onDismiss: {}
    )
}
