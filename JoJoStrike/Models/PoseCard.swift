import Foundation

struct JointAngleTarget: Codable, Sendable, Equatable {
    let joint: String
    let minAngle: Double
    let maxAngle: Double
    let weight: Double

    init(_ joint: String, min: Double, max: Double, weight: Double = 1.0) {
        self.joint = joint
        self.minAngle = min
        self.maxAngle = max
        self.weight = weight
    }
}

struct PoseCard: Identifiable, Sendable, Equatable {
    let id: String
    let name: String
    let character: String
    let part: Int
    let partName: String
    let description: String
    let difficulty: Int
    let category: PoseCategory
    let rarity: CardRarity
    let iconicPhrase: String
    let imageName: String
    let jointTargets: [JointAngleTarget]

    var starsDisplay: String {
        String(repeating: "★", count: rarity.stars)
    }

    var partDisplay: String {
        "Part \(part): \(partName)"
    }

    var difficultyDisplay: String {
        String(repeating: "🔥", count: difficulty)
    }

    var xpValue: Double {
        Double(difficulty) * rarity.xpMultiplier
    }

    static func == (lhs: PoseCard, rhs: PoseCard) -> Bool {
        lhs.id == rhs.id
    }
}
