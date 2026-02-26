import Foundation

struct CardPackService: Sendable {

    static func openPack(_ pack: CardPack, ownedCardIDs: Set<String>) -> [CollectibleCard] {
        var cards: [CollectibleCard] = []
        let allCards = CollectibleCardDatabase.allCards

        for i in 0..<pack.cardCount {
            let isLastCard = i == pack.cardCount - 1
            let rarity: CardRarity

            if isLastCard, let minRarity = pack.guaranteedMinRarity {
                rarity = rollRarityWithMinimum(minRarity)
            } else {
                rarity = CardDeckService.rollRarity()
            }

            let pool = allCards.filter { $0.rarity == rarity }
            if let card = pool.randomElement() {
                cards.append(card)
            } else if let fallback = allCards.randomElement() {
                cards.append(fallback)
            }
        }

        return cards
    }

    private static func rollRarityWithMinimum(_ minimum: CardRarity) -> CardRarity {
        let minimumOrder = rarityOrder(minimum)
        var rarity = CardDeckService.rollRarity()

        if rarityOrder(rarity) < minimumOrder {
            rarity = minimum
        }

        return rarity
    }

    private static func rarityOrder(_ rarity: CardRarity) -> Int {
        switch rarity {
        case .common: 0
        case .rare: 1
        case .epic: 2
        case .legendary: 3
        case .bizarre: 4
        }
    }
}
