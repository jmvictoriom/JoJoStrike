import SwiftUI
import SwiftData

@Observable
@MainActor
final class CardSwipeViewModel {
    private(set) var deck: [PoseCard] = []
    private(set) var currentIndex: Int = 0
    private(set) var swipedRight: [String] = []
    private(set) var swipedLeft: [String] = []
    var selectedPoseForChallenge: PoseCard?

    var currentCard: PoseCard? {
        guard currentIndex < deck.count else { return nil }
        return deck[currentIndex]
    }

    var upcomingCards: [PoseCard] {
        let start = currentIndex
        let end = min(currentIndex + 3, deck.count)
        guard start < end else { return [] }
        return Array(deck[start..<end])
    }

    var cardsRemaining: Int {
        max(0, deck.count - currentIndex)
    }

    var progress: Double {
        guard !deck.isEmpty else { return 0 }
        return Double(currentIndex) / Double(deck.count)
    }

    init() {
        shuffleDeck()
    }

    func shuffleDeck() {
        deck = buildWeightedDeck().shuffled()
        currentIndex = 0
        swipedRight = []
        swipedLeft = []
    }

    func swipe(_ direction: SwipeDirection) {
        guard let card = currentCard else { return }

        switch direction {
        case .right:
            swipedRight.append(card.id)
            selectedPoseForChallenge = card
            HapticsService.swipeRight()
        case .left:
            swipedLeft.append(card.id)
            HapticsService.swipeLeft()
        }

        currentIndex += 1

        if currentIndex >= deck.count {
            reshuffleDeck()
        }
    }

    func dismissChallenge() {
        selectedPoseForChallenge = nil
    }

    private func reshuffleDeck() {
        deck = buildWeightedDeck().shuffled()
        currentIndex = 0
    }

    private func buildWeightedDeck() -> [PoseCard] {
        var weighted: [PoseCard] = []
        for pose in PoseDatabase.allPoses {
            let copies: Int
            switch pose.rarity {
            case .common: copies = 4
            case .rare: copies = 3
            case .epic: copies = 2
            case .legendary: copies = 1
            case .bizarre: copies = 1
            }
            weighted.append(contentsOf: Array(repeating: pose, count: copies))
        }
        return weighted
    }
}
