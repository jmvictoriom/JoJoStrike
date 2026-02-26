import SwiftUI

struct CollectibleCardDetailView: View {
    let card: CollectibleCard
    let isOwned: Bool
    let count: Int

    private var cardIndex: Int {
        (CollectibleCardDatabase.allCards.firstIndex(where: { $0.id == card.id }) ?? 0) + 1
    }

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Card
                    CollectibleCardView(
                        card: card,
                        cardNumber: cardIndex,
                        totalCards: CollectibleCardDatabase.allCards.count,
                        showFull: true
                    )
                    .frame(maxWidth: 300)
                    .padding(.horizontal, 40)

                    if isOwned {
                        ownedBadge

                        // Bio
                        bioSection

                        // Stand ability
                        if let ability = card.standAbility {
                            abilitySection(ability)
                        }
                    } else {
                        lockedView
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: - Owned Badge

    private var ownedBadge: some View {
        HStack {
            if count > 1 {
                Text("Posees ×\(count)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.jojoGold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.jojoGold.opacity(0.15))
                    .clipShape(Capsule())
            }
        }
    }

    // MARK: - Bio

    private var bioSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.text.rectangle")
                    .foregroundStyle(.jojoGold)
                Text("Biografía")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
            }

            Text(card.characterBio)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Stand Ability

    private func abilitySection(_ ability: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundStyle(.jojoPurple)
                Text("Habilidad del Stand")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
            }

            if let standName = card.standName {
                Text(standName)
                    .font(.subheadline.bold())
                    .foregroundStyle(card.rarity.color)
            }

            Text(ability)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Locked

    private var lockedView: some View {
        VStack(spacing: 12) {
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .foregroundStyle(.gray)

            Text("Carta no descubierta")
                .font(.headline)
                .foregroundStyle(.gray)

            Text("Compra sobres en la Tienda para desbloquear esta carta.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
