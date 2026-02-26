import SwiftUI
import SwiftData

struct CollectibleCollectionView: View {
    @Environment(CurrentProfileProvider.self) private var profileProvider
    @State private var vm = CollectibleCollectionViewModel()

    private var ownedCards: [OwnedCollectibleCard] {
        profileProvider.profile?.ownedCards ?? []
    }

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        progressHeader

                        filterBar

                        cardGrid
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Colección")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if vm.selectedRarity != nil || vm.selectedPart != nil {
                        Button("Limpiar") {
                            withAnimation { vm.clearFilters() }
                        }
                        .foregroundStyle(.jojoGold)
                    }
                }
            }
        }
    }

    // MARK: - Progress Header

    private var progressHeader: some View {
        let owned = vm.ownedTotal(ownedCards: ownedCards)
        let total = vm.totalCards

        return VStack(spacing: 8) {
            HStack {
                Text("\(owned)/\(total)")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundStyle(.jojoGold)

                Text("cartas coleccionadas")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(.white.opacity(0.1))
                    Capsule()
                        .fill(.jojoGold.gradient)
                        .frame(width: geo.size.width * CGFloat(owned) / max(1, CGFloat(total)))
                }
            }
            .frame(height: 6)

            // Per-part progress
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(vm.availableParts, id: \.self) { part in
                        partChip(part)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func partChip(_ part: Int) -> some View {
        let partCards = CollectibleCardDatabase.cards(forPart: part)
        let ownedIDs = Set(ownedCards.map(\.cardID))
        let count = partCards.filter { ownedIDs.contains($0.id) }.count
        let progress = partCards.isEmpty ? 0.0 : Double(count) / Double(partCards.count)

        return VStack(spacing: 2) {
            Text("Part \(part)")
                .font(.caption2.bold())
                .foregroundStyle(progress >= 1.0 ? .jojoGold : .secondary)
            Text("\(count)/\(partCards.count)")
                .font(.caption2)
                .foregroundStyle(progress >= 1.0 ? .jojoGold : .white.opacity(0.6))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(progress >= 1.0 ? .jojoGold.opacity(0.15) : .white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    // MARK: - Filters

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(CardRarity.allCases) { rarity in
                    Button {
                        withAnimation {
                            vm.selectedRarity = vm.selectedRarity == rarity ? nil : rarity
                        }
                    } label: {
                        Text(rarity.displayName)
                            .font(.caption.bold())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(vm.selectedRarity == rarity ? rarity.color.opacity(0.3) : .white.opacity(0.05))
                            .foregroundStyle(vm.selectedRarity == rarity ? rarity.color : .white)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Card Grid

    private var cardGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(vm.filteredCards) { card in
                let owned = vm.isOwned(card.id, ownedCards: ownedCards)

                NavigationLink {
                    CollectibleCardDetailView(
                        card: card,
                        isOwned: owned,
                        count: vm.ownedCount(card.id, ownedCards: ownedCards)
                    )
                } label: {
                    collectibleCardTile(card: card, owned: owned)
                }
            }
        }
        .padding(.horizontal)
    }

    private func collectibleCardTile(card: CollectibleCard, owned: Bool) -> some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(owned ? card.rarity.color.opacity(0.15) : .white.opacity(0.03))
                    .frame(height: 120)

                if owned {
                    Image(card.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(8)
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: 30))
                        .foregroundStyle(.gray.opacity(0.3))
                }

                VStack {
                    HStack {
                        Text(card.starsDisplay)
                            .font(.caption2)
                            .foregroundStyle(owned ? card.rarity.color : .gray.opacity(0.3))
                        Spacer()
                    }
                    Spacer()

                    if owned, let standName = card.standName {
                        HStack {
                            Spacer()
                            Text(standName)
                                .font(.system(size: 8))
                                .foregroundStyle(.white.opacity(0.7))
                                .lineLimit(1)
                        }
                    }
                }
                .padding(6)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        owned ? card.rarity.color.opacity(0.5) : .gray.opacity(0.1),
                        lineWidth: owned ? 1.5 : 0.5
                    )
            }

            Text(owned ? card.characterName : "???")
                .font(.caption2.bold())
                .foregroundStyle(owned ? .white : .gray)
                .lineLimit(1)
        }
    }
}

#Preview {
    CollectibleCollectionView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
