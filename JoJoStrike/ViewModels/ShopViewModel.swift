import SwiftUI
import SwiftData

@Observable
@MainActor
final class ShopViewModel {
    var availablePacks: [CardPack] = CardPack.allPacks
    var isPurchasing: Bool = false
    var revealedCards: [CollectibleCard] = []
    var showPackOpening: Bool = false
    var purchaseError: String?
    var duplicateRefunds: [String: Int] = [:]
    var newCardIDs: Set<String> = []

    func purchasePack(_ pack: CardPack, profile: UserProfile, context: ModelContext) {
        guard !isPurchasing else { return }
        guard profile.coins >= pack.price else {
            purchaseError = "No tienes suficientes monedas"
            return
        }

        isPurchasing = true
        purchaseError = nil

        // Deduct coins
        let success = CoinService.deductCoins(pack.price, from: profile)
        guard success else {
            isPurchasing = false
            return
        }

        // Get owned card IDs
        let ownedIDs = Set(profile.ownedCards.map(\.cardID))

        // Open pack
        let cards = CardPackService.openPack(pack, ownedCardIDs: ownedIDs)
        revealedCards = cards
        duplicateRefunds = [:]
        newCardIDs = []

        // Process each card
        for card in cards {
            if let existing = profile.ownedCards.first(where: { $0.cardID == card.id }) {
                // Duplicate - refund
                existing.count += 1
                let refund = CoinService.duplicateRefund(for: card.rarity)
                CoinService.awardCoins(refund, to: profile)
                duplicateRefunds[card.id] = refund
            } else {
                // New card
                let owned = OwnedCollectibleCard(cardID: card.id)
                profile.ownedCards.append(owned)
                newCardIDs.insert(card.id)
            }
        }

        try? context.save()
        showPackOpening = true
        isPurchasing = false
    }

    func canAfford(_ pack: CardPack, coins: Int) -> Bool {
        coins >= pack.price
    }

    func resetPackOpening() {
        showPackOpening = false
        revealedCards = []
        duplicateRefunds = [:]
        newCardIDs = []
    }
}
