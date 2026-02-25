import SwiftUI

struct PoseCardView: View {
    let card: PoseCard
    var onTryPose: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            // Header: rarity
            rarityHeader

            // Image area
            imageArea

            // Info section
            infoSection
        }
        .frame(width: 320, height: 480)
        .background(Color.jojoCardBg)
        .rarityBorder(card.rarity)
        .menacing(active: card.rarity.hasMenacingEffect, color: card.rarity.color)
        .overlay {
            if card.rarity.hasParticleEffect {
                ParticleEffect(rarity: card.rarity, particleCount: card.rarity == .bizarre ? 20 : 10)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .shadow(color: card.rarity.color.opacity(0.3), radius: card.rarity.hasGlowBorder ? 12 : 4)
    }

    // MARK: - Rarity Header

    private var rarityHeader: some View {
        HStack {
            Text(card.starsDisplay)
                .font(.caption)

            Text(card.rarity.displayName)
                .font(.system(size: 11, weight: .black))
                .tracking(2)

            Text(card.starsDisplay)
                .font(.caption)
        }
        .foregroundStyle(card.rarity.color)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(card.rarity.color.opacity(0.1))
    }

    // MARK: - Image Area

    private var imageArea: some View {
        ZStack {
            LinearGradient(
                colors: [Color.jojoDarkBg, card.rarity.color.opacity(0.15)],
                startPoint: .top,
                endPoint: .bottom
            )

            // Pose silhouette figure
            PoseSilhouetteView(
                poseID: card.id,
                color: card.rarity.color,
                lineWidth: 4,
                showGlow: card.rarity.hasGlowBorder
            )
            .padding(20)

            // Category badge
            VStack {
                HStack {
                    Spacer()
                    Text(card.category.emoji)
                        .font(.title3)
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .padding(8)
                }
                Spacer()
            }
        }
        .frame(height: 200)
    }

    // MARK: - Info Section

    private var infoSection: some View {
        VStack(spacing: 8) {
            Text(card.name)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Text(card.partDisplay)
                .font(.caption)
                .foregroundStyle(card.rarity.color.opacity(0.8))

            Divider()
                .background(card.rarity.color.opacity(0.3))
                .padding(.horizontal)

            HStack(spacing: 16) {
                Label {
                    Text("\(card.difficulty)/5")
                        .font(.caption.bold())
                } icon: {
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.orange)
                }

                Label {
                    Text(card.category.displayName)
                        .font(.caption)
                } icon: {
                    Text(card.category.emoji)
                        .font(.caption)
                }
            }
            .foregroundStyle(.secondary)

            Text("\"\(card.iconicPhrase)\"")
                .font(.system(size: 12, weight: .medium, design: .serif))
                .italic()
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, 12)

            if let action = onTryPose {
                Button(action: action) {
                    Label("INTENTAR POSE", systemImage: "bolt.fill")
                        .font(.system(size: 14, weight: .black))
                        .tracking(1)
                        .foregroundStyle(Color.jojoDarkBg)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(card.rarity.color.gradient)
                        .clipShape(Capsule())
                }
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
    }
}

#Preview("Legendary") {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        PoseCardView(card: PoseDatabase.allPoses[2])
    }
}

#Preview("Bizarre") {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        PoseCardView(card: PoseDatabase.allPoses[0])
    }
}

#Preview("Common") {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        PoseCardView(card: PoseDatabase.allPoses[20])
    }
}
