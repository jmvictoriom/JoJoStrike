import SwiftUI

enum Medal: String, CaseIterable, Codable, Sendable, Comparable {
    case none
    case bronze
    case silver
    case gold
    case platinum

    var displayName: String {
        switch self {
        case .none: "---"
        case .bronze: "Bronze"
        case .silver: "Silver"
        case .gold: "Gold"
        case .platinum: "Platinum"
        }
    }

    var emoji: String {
        switch self {
        case .none: ""
        case .bronze: "🥉"
        case .silver: "🥈"
        case .gold: "🥇"
        case .platinum: "💎"
        }
    }

    var color: Color {
        switch self {
        case .none: .gray
        case .bronze: Color(red: 0.80, green: 0.50, blue: 0.20)
        case .silver: .jojoSilver
        case .gold: .jojoGold
        case .platinum: Color(red: 0.60, green: 0.85, blue: 1.0)
        }
    }

    var minimumScore: Int {
        switch self {
        case .none: 0
        case .bronze: 60
        case .silver: 75
        case .gold: 85
        case .platinum: 95
        }
    }

    var baseXPMultiplier: Double {
        switch self {
        case .none: 0
        case .bronze: 10
        case .silver: 20
        case .gold: 35
        case .platinum: 50
        }
    }

    static func from(score: Int) -> Medal {
        if score >= Medal.platinum.minimumScore { return .platinum }
        if score >= Medal.gold.minimumScore { return .gold }
        if score >= Medal.silver.minimumScore { return .silver }
        if score >= Medal.bronze.minimumScore { return .bronze }
        return .none
    }

    private var sortOrder: Int {
        switch self {
        case .none: 0
        case .bronze: 1
        case .silver: 2
        case .gold: 3
        case .platinum: 4
        }
    }

    static func < (lhs: Medal, rhs: Medal) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}
