import Foundation

enum PoseCategory: String, CaseIterable, Codable, Sendable, Identifiable {
    case menacing
    case fabulous
    case battle
    case dramatic
    case casual

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .menacing: "Menacing"
        case .fabulous: "Fabulous"
        case .battle: "Battle"
        case .dramatic: "Dramatic"
        case .casual: "Casual"
        }
    }

    var emoji: String {
        switch self {
        case .menacing: "ゴゴゴ"
        case .fabulous: "✨"
        case .battle: "⚔️"
        case .dramatic: "🎭"
        case .casual: "😎"
        }
    }
}
