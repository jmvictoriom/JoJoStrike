import SwiftUI

struct CardRevealView: View {
    let card: CollectibleCard
    let isRevealed: Bool
    let isNew: Bool
    let refund: Int?
    let onReveal: () -> Void

    @State private var rotationAngle: Double = 0

    var body: some View {
        ZStack {
            if isRevealed {
                revealedSide
            } else {
                hiddenSide
            }
        }
        .frame(height: 160)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            guard !isRevealed else { return }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                rotationAngle = 360
            }
            onReveal()
        }
    }

    private var hiddenSide: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.jojoPurple.gradient)

            VStack(spacing: 4) {
                Image(systemName: "questionmark")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white.opacity(0.5))
                Text("Toca")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.white.opacity(0.2), lineWidth: 1)
        }
    }

    private var revealedSide: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(card.rarity.color.opacity(0.15))

            VStack(spacing: 4) {
                Text(card.starsDisplay)
                    .font(.caption2)
                    .foregroundStyle(card.rarity.color)

                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 70)

                Text(card.characterName)
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                if let standName = card.standName {
                    Text(standName)
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                if isNew {
                    Text("¡NUEVA!")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.green)
                } else if let refund {
                    HStack(spacing: 1) {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.system(size: 8))
                        Text("+\(refund)")
                            .font(.system(size: 9, weight: .bold))
                    }
                    .foregroundStyle(.jojoGold)
                }
            }
            .padding(6)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(card.rarity.color.opacity(0.6), lineWidth: card.rarity.borderWidth)
        }
    }
}
