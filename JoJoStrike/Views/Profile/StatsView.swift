import SwiftUI

struct StatsView: View {
    let vm: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Overview
                statsSection("Overview") {
                    statRow("Total Attempts", value: "\(vm.totalAttempts)")
                    statRow("Poses Completed", value: "\(vm.totalPosesCompleted)/30")
                    statRow("Best Score", value: "\(vm.bestScore)%")
                    statRow("Average Score", value: "\(vm.averageScore)%")
                }

                // Medals
                statsSection("Medals") {
                    HStack(spacing: 20) {
                        ForEach([Medal.platinum, .gold, .silver, .bronze], id: \.self) { medal in
                            VStack(spacing: 4) {
                                Text(medal.emoji)
                                    .font(.title2)
                                Text("\(vm.medalCounts[medal] ?? 0)")
                                    .font(.headline.bold())
                                    .foregroundStyle(medal.color)
                                Text(medal.displayName)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }

                // Streaks
                statsSection("Streaks") {
                    statRow("Current Streak", value: "\(vm.currentStreak) days")
                    statRow("Best Streak", value: "\(vm.bestStreak) days")
                }

                // Achievements
                statsSection("Achievements") {
                    let progress = vm.achievementProgress
                    statRow("Unlocked", value: "\(progress.unlocked)/\(progress.total)")

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(.white.opacity(0.1))
                            Capsule()
                                .fill(.jojoGold.gradient)
                                .frame(width: geo.size.width * CGFloat(progress.unlocked) / max(1, CGFloat(progress.total)))
                        }
                    }
                    .frame(height: 6)
                }
            }
            .padding()
        }
        .background(Color.jojoDarkBg)
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func statsSection(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.bold())
                .foregroundStyle(.jojoGold)

            VStack(spacing: 10) {
                content()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.jojoCardBg)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private func statRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.body.bold())
                .foregroundStyle(.white)
        }
    }
}
