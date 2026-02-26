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
                        quickStats
                        navigationLinks
                    }
                    .padding()
                }
            }
            .navigationTitle("Perfil")
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

            // Coin balance
            HStack(spacing: 4) {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundStyle(.jojoGold)
                Text("\(vm.profile?.coins ?? 0) monedas")
                    .font(.subheadline.bold())
                    .foregroundStyle(.jojoGold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(.jojoGold.opacity(0.15))
            .clipShape(Capsule())
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

    // MARK: - Quick Stats

    private var quickStats: some View {
        let ownedCount = vm.profile?.ownedCards.count ?? 0
        let totalCards = CollectibleCardDatabase.allCards.count

        return VStack(spacing: 12) {
            HStack(spacing: 12) {
                quickStat(value: "\(vm.totalPosesCompleted)", label: "Poses", icon: "figure.stand", color: .jojoPurple)
                quickStat(value: "\(vm.totalAttempts)", label: "Intentos", icon: "arrow.counterclockwise", color: .jojoBlue)
                quickStat(value: "\(vm.bestScore)%", label: "Mejor", icon: "star.fill", color: .jojoGold)
            }
            HStack(spacing: 12) {
                quickStat(value: "\(ownedCount)/\(totalCards)", label: "Cartas", icon: "rectangle.stack.fill", color: .jojoRed)
                quickStat(value: "\(vm.achievementProgress.unlocked)", label: "Logros", icon: "trophy.fill", color: .jojoOrange)
                quickStat(value: "\(vm.currentStreak)", label: "Racha", icon: "flame.fill", color: .jojoOrange)
            }
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
                navRow("Logros", icon: "trophy.fill", detail: "\(vm.achievementProgress.unlocked)/\(vm.achievementProgress.total)")
            }

            NavigationLink {
                StatsView(vm: vm)
            } label: {
                navRow("Estadísticas", icon: "chart.bar.fill", detail: nil)
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
