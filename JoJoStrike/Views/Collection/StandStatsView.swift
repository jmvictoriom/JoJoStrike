import SwiftUI

struct StandStatsView: View {
    let stats: StandStats

    private let labels: [(String, KeyPath<StandStats, StatRating>)] = [
        ("Poder", \.destructivePower),
        ("Veloc", \.speed),
        ("Alcance", \.range),
        ("Durab", \.durability),
        ("Prec", \.precision),
        ("Desar", \.developmentPotential)
    ]

    var body: some View {
        VStack(spacing: 6) {
            ForEach(labels, id: \.0) { label, keyPath in
                let rating = stats[keyPath: keyPath]
                statRow(label: label, rating: rating)
            }
        }
    }

    private func statRow(label: String, rating: StatRating) -> some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 50, alignment: .leading)

            Text(rating.display)
                .font(.caption.bold())
                .foregroundStyle(rating.color)
                .frame(width: 16)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white.opacity(0.1))

                    Capsule()
                        .fill(rating.color.gradient)
                        .frame(width: geo.size.width * rating.numericValue)
                }
            }
            .frame(height: 6)
        }
    }
}
