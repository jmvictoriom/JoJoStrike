import SwiftUI
import SwiftData

struct CardDetailView: View {
    let card: PoseCard
    let isUnlocked: Bool
    let bestMedal: Medal
    let bestScore: Int
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Card preview
                PoseCardView(card: card)
                    .scaleEffect(0.85)
                    .frame(height: 420)

                if isUnlocked {
                    unlockedContent
                } else {
                    lockedContent
                }
            }
            .padding()
        }
        .background(Color.jojoDarkBg)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(card.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var unlockedContent: some View {
        VStack(spacing: 16) {
            // Best score
            HStack {
                VStack(alignment: .leading) {
                    Text("Mejor Puntuación")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(bestScore)%")
                        .font(.title.bold())
                        .foregroundStyle(bestMedal.color)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Medalla")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    HStack {
                        Text(bestMedal.emoji)
                        Text(bestMedal.displayName)
                            .font(.title3.bold())
                            .foregroundStyle(bestMedal.color)
                    }
                }
            }
            .padding()
            .background(.jojoCardBg)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Stats
            HStack(spacing: 20) {
                statItem(label: "Dificultad", value: "\(card.difficulty)/5", icon: "flame.fill", color: .orange)
                statItem(label: "Rareza", value: card.rarity.displayName, icon: "sparkles", color: card.rarity.color)
                statItem(label: "Categoría", value: card.category.displayName, icon: "tag.fill", color: .jojoPurple)
            }

            // Character info
            VStack(alignment: .leading, spacing: 8) {
                Text("Personaje")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(card.character)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text(card.partDisplay)
                    .font(.subheadline)
                    .foregroundStyle(card.rarity.color)

                Divider().background(.white.opacity(0.1))

                Text(card.description)
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.8))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.jojoCardBg)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    private var lockedContent: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.fill")
                .font(.system(size: 40))
                .foregroundStyle(.gray)

            Text("Carta Bloqueada")
                .font(.title2.bold())
                .foregroundStyle(.gray)

            Text("Completa esta pose para desbloquear la carta")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }

    private func statItem(label: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            Text(value)
                .font(.caption.bold())
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
}

#Preview {
    NavigationStack {
        CardDetailView(
            card: PoseDatabase.allPoses[2],
            isUnlocked: true,
            bestMedal: .gold,
            bestScore: 87
        )
    }
}
