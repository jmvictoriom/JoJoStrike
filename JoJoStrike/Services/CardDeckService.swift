import Foundation

struct CardDeckService: Sendable {
    static func buildDeck(excludingIDs: Set<String> = []) -> [PoseCard] {
        var deck: [PoseCard] = []

        for pose in PoseDatabase.allPoses {
            if excludingIDs.contains(pose.id) { continue }

            let copies: Int
            switch pose.rarity {
            case .common: copies = 4
            case .rare: copies = 3
            case .epic: copies = 2
            case .legendary: copies = 1
            case .bizarre: copies = 1
            }
            deck.append(contentsOf: Array(repeating: pose, count: copies))
        }

        return deck.shuffled()
    }

    static func randomPose(rarity: CardRarity? = nil) -> PoseCard? {
        let pool: [PoseCard]
        if let rarity {
            pool = PoseDatabase.poses(forRarity: rarity)
        } else {
            pool = PoseDatabase.allPoses
        }
        return pool.randomElement()
    }

    static func rollRarity() -> CardRarity {
        let roll = Double.random(in: 0...1)
        var cumulative: Double = 0

        for rarity in CardRarity.allCases {
            cumulative += rarity.dropRate
            if roll <= cumulative {
                return rarity
            }
        }

        return .common
    }
}
