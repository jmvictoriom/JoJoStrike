import SwiftUI

enum CardRarity: String, CaseIterable, Codable, Sendable, Identifiable {
    case common
    case rare
    case epic
    case legendary
    case bizarre

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .common: "COMMON"
        case .rare: "RARE"
        case .epic: "EPIC"
        case .legendary: "LEGENDARY"
        case .bizarre: "BIZARRE"
        }
    }

    var stars: Int {
        switch self {
        case .common: 1
        case .rare: 2
        case .epic: 3
        case .legendary: 4
        case .bizarre: 5
        }
    }

    var color: Color {
        switch self {
        case .common: .jojoSilver
        case .rare: .jojoBlue
        case .epic: .jojoPurple
        case .legendary: .jojoGold
        case .bizarre: .jojoRed
        }
    }

    var gradientColors: [Color] {
        switch self {
        case .common:
            [.jojoSilver, .gray]
        case .rare:
            [.jojoBlue, Color(red: 0.0, green: 0.3, blue: 0.8)]
        case .epic:
            [.jojoPurple, Color(red: 0.5, green: 0.2, blue: 0.8)]
        case .legendary:
            [.jojoGold, .jojoRed]
        case .bizarre:
            [.jojoRed, .jojoPurple, .jojoBlue, .jojoGold, .jojoOrange]
        }
    }

    var xpMultiplier: Double {
        switch self {
        case .common: 1.0
        case .rare: 1.5
        case .epic: 2.0
        case .legendary: 3.0
        case .bizarre: 5.0
        }
    }

    var dropRate: Double {
        switch self {
        case .common: 0.40
        case .rare: 0.30
        case .epic: 0.18
        case .legendary: 0.10
        case .bizarre: 0.02
        }
    }

    var hasMenacingEffect: Bool {
        self == .legendary || self == .bizarre
    }

    var hasHolographicEffect: Bool {
        self == .bizarre
    }

    var hasParticleEffect: Bool {
        self == .epic || self == .legendary || self == .bizarre
    }

    var hasGlowBorder: Bool {
        self != .common
    }

    var borderWidth: CGFloat {
        switch self {
        case .common: 1.5
        case .rare: 2.0
        case .epic: 2.5
        case .legendary: 3.0
        case .bizarre: 3.5
        }
    }
}
