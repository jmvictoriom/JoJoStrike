import SwiftUI

struct TrainingPoseRow: View {
    let pose: PoseCard
    let medal: Medal
    let potentialCoins: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Pose image
                Image(pose.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(pose.rarity.color.opacity(0.5), lineWidth: 1)
                    }

                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(pose.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .lineLimit(1)

                    HStack(spacing: 6) {
                        Text(pose.character)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)

                        Text("•")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text(pose.starsDisplay)
                            .font(.caption)
                            .foregroundStyle(pose.rarity.color)
                    }
                }

                Spacer()

                // Right side
                VStack(alignment: .trailing, spacing: 4) {
                    // Medal or difficulty
                    if medal != .none {
                        Text(medal.emoji)
                            .font(.title3)
                    } else {
                        Text(pose.difficultyDisplay)
                            .font(.caption)
                    }

                    // Coins
                    HStack(spacing: 2) {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(.jojoGold)
                        Text("\(potentialCoins)")
                            .font(.caption2.bold())
                            .foregroundStyle(.jojoGold)
                    }
                }

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .background(.jojoCardBg)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}
