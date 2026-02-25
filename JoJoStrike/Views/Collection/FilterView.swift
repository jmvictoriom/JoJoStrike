import SwiftUI

struct FilterView: View {
    @Binding var selectedRarity: CardRarity?
    @Binding var selectedPart: Int?
    @Binding var sortBy: CollectionViewModel.SortOption
    let availableParts: [Int]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                // Sort
                Menu {
                    ForEach(CollectionViewModel.SortOption.allCases, id: \.self) { option in
                        Button {
                            sortBy = option
                        } label: {
                            if sortBy == option {
                                Label(option.rawValue, systemImage: "checkmark")
                            } else {
                                Text(option.rawValue)
                            }
                        }
                    }
                } label: {
                    filterChip("Orden: \(sortBy.rawValue)", icon: "arrow.up.arrow.down", active: true)
                }

                // Rarity filter
                ForEach(CardRarity.allCases) { rarity in
                    Button {
                        selectedRarity = selectedRarity == rarity ? nil : rarity
                    } label: {
                        filterChip(rarity.displayName, color: rarity.color, active: selectedRarity == rarity)
                    }
                }

                Divider().frame(height: 20)

                // Part filter
                ForEach(availableParts, id: \.self) { part in
                    Button {
                        selectedPart = selectedPart == part ? nil : part
                    } label: {
                        filterChip("Part \(part)", active: selectedPart == part)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    private func filterChip(_ text: String, icon: String? = nil, color: Color = .jojoGold, active: Bool) -> some View {
        HStack(spacing: 4) {
            if let icon {
                Image(systemName: icon)
                    .font(.caption2)
            }
            Text(text)
                .font(.caption.bold())
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(active ? color.opacity(0.2) : .white.opacity(0.05))
        .foregroundStyle(active ? color : .secondary)
        .clipShape(Capsule())
        .overlay {
            Capsule().strokeBorder(active ? color.opacity(0.5) : .clear, lineWidth: 1)
        }
    }
}
