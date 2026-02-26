import SwiftUI

struct StandStats: Sendable, Equatable, Codable {
    let destructivePower: StatRating
    let speed: StatRating
    let range: StatRating
    let durability: StatRating
    let precision: StatRating
    let developmentPotential: StatRating
}

enum StatRating: String, CaseIterable, Codable, Sendable {
    case a, b, c, d, e, none

    var display: String {
        switch self {
        case .a: "A"
        case .b: "B"
        case .c: "C"
        case .d: "D"
        case .e: "E"
        case .none: "∅"
        }
    }

    var numericValue: CGFloat {
        switch self {
        case .a: 1.0
        case .b: 0.8
        case .c: 0.6
        case .d: 0.4
        case .e: 0.2
        case .none: 0.0
        }
    }

    var color: Color {
        switch self {
        case .a: .jojoGold
        case .b: Color(red: 0.3, green: 0.85, blue: 0.4)
        case .c: .jojoBlue
        case .d: .jojoOrange
        case .e: .gray
        case .none: .gray.opacity(0.3)
        }
    }
}
