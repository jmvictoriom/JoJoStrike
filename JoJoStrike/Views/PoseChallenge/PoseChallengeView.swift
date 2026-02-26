import SwiftUI
import SwiftData

struct PoseChallengeView: View {
    let poseID: String
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(CurrentProfileProvider.self) private var profileProvider
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
                coinsEarned: vm.coinsEarned,
                onDismiss: { dismiss() }
            )
            .onAppear { awardRewards(vm: vm, score: score, medal: medal) }
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

            Text("¡Prepárate!")
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
                        Text("Similitud")
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
                        Text("Mejor: \(vm.bestScore)%")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
            }

            // Reference pose image
            VStack {
                Spacer()
                HStack {
                    VStack(spacing: 4) {
                        Image(vm.pose.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.jojoGold.opacity(0.6), lineWidth: 2)
                            )
                            .shadow(color: .black.opacity(0.5), radius: 6)

                        Text("Referencia")
                            .font(.caption2.bold())
                            .foregroundStyle(.jojoGold)
                    }
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.leading, 12)
                    .padding(.bottom, 90)

                    Spacer()
                }
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
            Text("Cancelar")
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

    private func awardRewards(vm: PoseChallengeViewModel, score: Int, medal: Medal) {
        guard let profile = profileProvider.profile else { return }

        let isDaily = vm.pose.id == GamificationService.dailyChallengePose().id
        let isFirst = !profile.attempts.contains { $0.poseID == vm.pose.id && $0.score >= Medal.bronze.minimumScore }

        vm.calculateCoins(isDailyChallenge: isDaily, isFirstCompletion: isFirst)
        CoinService.awardCoins(vm.coinsEarned, to: profile)

        // Save attempt
        let attempt = PoseAttemptRecord(poseID: vm.pose.id, score: score, medal: medal.rawValue)
        profile.attempts.append(attempt)

        // Unlock pose
        if medal != .none && !profile.unlockedPoseIDs.contains(vm.pose.id) {
            profile.unlockedPoseIDs.append(vm.pose.id)
        }

        // XP
        let xp = GamificationService.calculateXP(
            pose: vm.pose, medal: medal,
            isFirstCompletion: isFirst, isDailyChallenge: isDaily
        )
        profile.totalXP += xp
        profile.level = GamificationService.levelFromTotalXP(profile.totalXP)

        // Streak
        GamificationService.updateStreak(profile: profile)

        // Achievements
        let newAchievements = GamificationService.checkAchievements(profile: profile)
        for ach in newAchievements {
            profile.unlockedPoseIDs.append("ach_\(ach.id)")
        }

        try? modelContext.save()
    }
}

#Preview {
    PoseChallengeView(poseID: "dio-wryyy")
}
