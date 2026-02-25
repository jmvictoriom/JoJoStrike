import SwiftUI

struct AchievementsView: View {
    let achievements: [Achievement]
    let unlockedIDs: Set<String>

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(achievements) { achievement in
                    let isUnlocked = unlockedIDs.contains("ach_\(achievement.id)")
                    achievementCard(achievement, unlocked: isUnlocked)
                }
            }
            .padding()
        }
        .background(Color.jojoDarkBg)
        .navigationTitle("Logros")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func achievementCard(_ achievement: Achievement, unlocked: Bool) -> some View {
        VStack(spacing: 8) {
            Image(systemName: achievement.iconName)
                .font(.system(size: 28))
                .foregroundStyle(unlocked ? .jojoGold : .gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .background(unlocked ? .jojoGold.opacity(0.15) : .white.opacity(0.03))
                .clipShape(Circle())

            Text(achievement.title)
                .font(.caption.bold())
                .foregroundStyle(unlocked ? .white : .gray)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Text(achievement.description)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            if unlocked {
                HStack(spacing: 2) {
                    Image(systemName: "bolt.fill")
                        .font(.caption2)
                    Text("+\(achievement.xpReward) XP")
                        .font(.caption2.bold())
                }
                .foregroundStyle(.jojoGold)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            if unlocked {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.jojoGold.opacity(0.3), lineWidth: 1)
            }
        }
        .opacity(unlocked ? 1 : 0.5)
    }
}
