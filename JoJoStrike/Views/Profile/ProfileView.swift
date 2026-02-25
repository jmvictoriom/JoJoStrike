import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var vm = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        avatarSection
                        xpSection
                        dailyChallengeCard
                        quickStats
                        navigationLinks
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear { vm.ensureProfile(in: modelContext) }
        }
    }

    // MARK: - Avatar

    private var avatarSection: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(.jojoGold.gradient)
                .frame(width: 90, height: 90)
                .overlay {
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.jojoDarkBg)
                }
                .shadow(color: .jojoGold.opacity(0.3), radius: 12)

            Text(vm.profile?.displayName ?? "Stand User")
                .font(.title2.bold())
                .foregroundStyle(.white)

            Text(vm.title)
                .font(.subheadline)
                .foregroundStyle(.jojoGold)
                .tracking(1)
        }
    }

    // MARK: - XP

    private var xpSection: some View {
        VStack(spacing: 8) {
            XPProgressBar(
                currentXP: vm.xpProgress.current,
                requiredXP: vm.xpProgress.required,
                level: vm.level
            )

            Text("\(vm.profile?.totalXP ?? 0) total XP")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Daily Challenge

    private var dailyChallengeCard: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "calendar.badge.clock")
                    .foregroundStyle(.jojoOrange)
                Text("Daily Challenge")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                Spacer()
                Text("x2 XP")
                    .font(.caption.bold())
                    .foregroundStyle(.jojoOrange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.jojoOrange.opacity(0.2))
                    .clipShape(Capsule())
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.dailyChallenge.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                    Text(vm.dailyChallenge.partDisplay)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text(vm.dailyChallenge.difficultyDisplay)
                    .font(.caption)
            }

            if vm.currentStreak > 0 {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.jojoOrange)
                    Text("\(vm.currentStreak) day streak!")
                        .font(.caption.bold())
                        .foregroundStyle(.jojoOrange)
                    Spacer()
                }
            }
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.jojoOrange.opacity(0.3), lineWidth: 1)
        }
    }

    // MARK: - Quick Stats

    private var quickStats: some View {
        HStack(spacing: 12) {
            quickStat(value: "\(vm.totalPosesCompleted)", label: "Poses", icon: "figure.stand", color: .jojoPurple)
            quickStat(value: "\(vm.totalAttempts)", label: "Attempts", icon: "arrow.counterclockwise", color: .jojoBlue)
            quickStat(value: "\(vm.bestScore)%", label: "Best", icon: "star.fill", color: .jojoGold)
            quickStat(value: "\(vm.achievementProgress.unlocked)", label: "Achievements", icon: "trophy.fill", color: .jojoOrange)
        }
    }

    private func quickStat(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            Text(value)
                .font(.headline.bold())
                .foregroundStyle(.white)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    // MARK: - Navigation

    private var navigationLinks: some View {
        VStack(spacing: 8) {
            NavigationLink {
                AchievementsView(
                    achievements: AchievementDatabase.allAchievements,
                    unlockedIDs: Set(vm.profile?.unlockedPoseIDs ?? [])
                )
            } label: {
                navRow("Achievements", icon: "trophy.fill", detail: "\(vm.achievementProgress.unlocked)/\(vm.achievementProgress.total)")
            }

            NavigationLink {
                StatsView(vm: vm)
            } label: {
                navRow("Statistics", icon: "chart.bar.fill", detail: nil)
            }
        }
    }

    private func navRow(_ title: String, icon: String, detail: String?) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.jojoGold)
                .frame(width: 30)

            Text(title)
                .foregroundStyle(.white)

            Spacer()

            if let detail {
                Text(detail)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
