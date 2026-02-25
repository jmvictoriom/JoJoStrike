import SwiftUI

struct StatsView: View {
    let vm: ProfileViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Overview
                statsSection("Resumen") {
                    statRow("Intentos Totales", value: "\(vm.totalAttempts)")
                    statRow("Poses Completadas", value: "\(vm.totalPosesCompleted)/30")
                    statRow("Mejor Puntuación", value: "\(vm.bestScore)%")
                    statRow("Puntuación Media", value: "\(vm.averageScore)%")
                }

                // Medals
                statsSection("Medallas") {
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
                statsSection("Rachas") {
                    statRow("Racha Actual", value: "\(vm.currentStreak) días")
                    statRow("Mejor Racha", value: "\(vm.bestStreak) días")
                }

                // Achievements
                statsSection("Logros") {
                    let progress = vm.achievementProgress
                    statRow("Desbloqueados", value: "\(progress.unlocked)/\(progress.total)")

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
        .navigationTitle("Estadísticas")
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
