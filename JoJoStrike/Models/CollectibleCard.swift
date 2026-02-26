import Foundation

struct CollectibleCard: Identifiable, Sendable, Equatable {
    let id: String
    let characterName: String
    let standName: String?
    let standAbility: String?
    let characterBio: String
    let part: Int
    let partName: String
    let rarity: CardRarity
    let imageName: String
    let standStats: StandStats?
    let abilityName: String?

    var partDisplay: String {
        "Part \(part): \(partName)"
    }

    var starsDisplay: String {
        String(repeating: "★", count: rarity.stars)
    }

    var hasStand: Bool {
        standName != nil
    }

    static func == (lhs: CollectibleCard, rhs: CollectibleCard) -> Bool {
        lhs.id == rhs.id
    }
}
