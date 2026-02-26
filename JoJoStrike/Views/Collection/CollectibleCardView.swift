import SwiftUI

struct CollectibleCardView: View {
    let card: CollectibleCard
    let cardNumber: Int
    let totalCards: Int
    var showFull: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // Header - Rarity
            HStack {
                Text(card.starsDisplay)
                    .font(.caption.bold())
                    .foregroundStyle(card.rarity.color)
                Spacer()
                Text(card.rarity.displayName)
                    .font(.caption2.bold())
                    .foregroundStyle(card.rarity.color)
                    .tracking(1)
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, 6)

            // Character image
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(card.rarity.color.opacity(0.1))
                    .padding(.horizontal, 10)

                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            }
            .frame(height: showFull ? 200 : 130)

            // Name
            VStack(spacing: 2) {
                Text(card.characterName.uppercased())
                    .font(.system(size: showFull ? 14 : 11, weight: .black))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                if let standName = card.standName {
                    Text("Stand: \(standName)")
                        .font(.system(size: showFull ? 11 : 9))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                } else if let ability = card.abilityName {
                    Text(ability)
                        .font(.system(size: showFull ? 11 : 9))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(.top, 6)

            // Stand Stats
            if let stats = card.standStats {
                Divider()
                    .background(.white.opacity(0.2))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)

                StandStatsView(stats: stats)
                    .padding(.horizontal, 12)
            }

            // Footer
            Divider()
                .background(.white.opacity(0.2))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)

            HStack {
                Text(card.partDisplay)
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Spacer()
                Text("#\(String(format: "%03d", cardNumber))/\(String(format: "%03d", totalCards))")
                    .font(.system(size: 8, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
        }
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(card.rarity.color.opacity(0.6), lineWidth: card.rarity.borderWidth)
        }
    }
}
