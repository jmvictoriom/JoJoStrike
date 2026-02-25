import SwiftUI

struct PoseChallengeView: View {
    let poseID: String
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: PoseChallengeViewModel?

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            if let vm = viewModel {
                challengeContent(vm)
            } else {
                ProgressView()
                    .tint(.jojoGold)
            }
        }
        .task {
            let vm = PoseChallengeViewModel(poseID: poseID)
            viewModel = vm
            await vm.startChallenge()
        }
        .onDisappear {
            viewModel?.stopChallenge()
        }
    }

    @ViewBuilder
    private func challengeContent(_ vm: PoseChallengeViewModel) -> some View {
        switch vm.phase {
        case .countdown:
            countdownView(vm)
        case .posing:
            posingView(vm)
        case let .finished(score, medal):
            PoseResultView(
                poseName: vm.pose.name,
                score: score,
                medal: medal,
                xpEarned: vm.xpEarned,
                onDismiss: { dismiss() }
            )
        }
    }

    // MARK: - Countdown

    private func countdownView(_ vm: PoseChallengeViewModel) -> some View {
        VStack(spacing: 24) {
            Text(vm.pose.name)
                .font(.title2.bold())
                .foregroundStyle(.white)

            Text(vm.pose.iconicPhrase)
                .font(.subheadline.italic())
                .foregroundStyle(.white.opacity(0.6))

            Spacer()

            Text("\(vm.countdown)")
                .font(.system(size: 120, weight: .black, design: .rounded))
                .foregroundStyle(.jojoGold)
                .contentTransition(.numericText())
                .animation(.spring, value: vm.countdown)

            Text("Get ready!")
                .font(.title3)
                .foregroundStyle(.secondary)

            Spacer()

            closeButton
        }
        .padding()
    }

    // MARK: - Posing

    private func posingView(_ vm: PoseChallengeViewModel) -> some View {
        ZStack {
            // Camera preview
            CameraPreviewView(session: vm.detectionService.session)
                .ignoresSafeArea()

            // Skeleton overlay
            PoseOverlayView(joints: vm.detectionService.detectedJoints, color: scoreColor(vm.currentScore))

            // UI overlay
            VStack {
                // Top bar
                HStack {
                    VStack(alignment: .leading) {
                        Text(vm.pose.name)
                            .font(.headline.bold())
                            .foregroundStyle(.white)
                        Text(vm.pose.partDisplay)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    Spacer()

                    // Timer
                    Text(String(format: "%.0f", vm.timeRemaining))
                        .font(.system(size: 36, weight: .black, design: .rounded))
                        .foregroundStyle(vm.timeRemaining < 5 ? .jojoRed : .white)
                        .contentTransition(.numericText())
                }
                .padding()
                .background(.ultraThinMaterial)

                Spacer()

                // Score bar
                VStack(spacing: 8) {
                    HStack {
                        Text("Match")
                            .font(.caption.bold())
                            .foregroundStyle(.white)

                        Spacer()

                        Text("\(vm.currentScore)%")
                            .font(.title2.bold())
                            .foregroundStyle(scoreColor(vm.currentScore))
                            .contentTransition(.numericText())
                    }

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(.white.opacity(0.2))
                            Capsule()
                                .fill(scoreColor(vm.currentScore).gradient)
                                .frame(width: geo.size.width * vm.matchProgress)
                                .animation(.easeOut(duration: 0.1), value: vm.matchProgress)
                        }
                    }
                    .frame(height: 8)

                    HStack {
                        Text("Best: \(vm.bestScore)%")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
            }

            // Close button overlay
            VStack {
                HStack {
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }

    private var closeButton: some View {
        Button { dismiss() } label: {
            Text("Cancel")
                .foregroundStyle(.secondary)
        }
        .padding(.bottom)
    }

    private func scoreColor(_ score: Int) -> Color {
        if score >= 95 { return Color(red: 0.60, green: 0.85, blue: 1.0) }
        if score >= 85 { return .jojoGold }
        if score >= 75 { return .jojoSilver }
        if score >= 60 { return Color(red: 0.80, green: 0.50, blue: 0.20) }
        return .gray
    }
}

#Preview {
    PoseChallengeView(poseID: "dio-wryyy")
}
