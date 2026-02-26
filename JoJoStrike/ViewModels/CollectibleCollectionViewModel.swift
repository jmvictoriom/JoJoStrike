import SwiftUI
import SwiftData

@Observable
@MainActor
final class CollectibleCollectionViewModel {
    var selectedRarity: CardRarity?
    var selectedPart: Int?

    var filteredCards: [CollectibleCard] {
        var cards = CollectibleCardDatabase.allCards

        if let rarity = selectedRarity {
            cards = cards.filter { $0.rarity == rarity }
        }
        if let part = selectedPart {
            cards = cards.filter { $0.part == part }
        }

        return cards.sorted { rarityOrder($0.rarity) > rarityOrder($1.rarity) }
    }

    func isOwned(_ cardID: String, ownedCards: [OwnedCollectibleCard]) -> Bool {
        ownedCards.contains { $0.cardID == cardID }
    }

    func ownedCount(_ cardID: String, ownedCards: [OwnedCollectibleCard]) -> Int {
        ownedCards.first { $0.cardID == cardID }?.count ?? 0
    }

    var totalCards: Int {
        CollectibleCardDatabase.allCards.count
    }

    func ownedTotal(ownedCards: [OwnedCollectibleCard]) -> Int {
        let ownedIDs = Set(ownedCards.map(\.cardID))
        return CollectibleCardDatabase.allCards.filter { ownedIDs.contains($0.id) }.count
    }

    var availableParts: [Int] {
        Array(Set(CollectibleCardDatabase.allCards.map(\.part))).sorted()
    }

    func clearFilters() {
        selectedRarity = nil
        selectedPart = nil
    }

    private func rarityOrder(_ rarity: CardRarity) -> Int {
        switch rarity {
        case .common: 0
        case .rare: 1
        case .epic: 2
        case .legendary: 3
        case .bizarre: 4
        }
    }
}
