import UIKit

@MainActor
struct HapticsService {
    static func swipeRight() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    static func swipeLeft() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    static func cardReveal(rarity: String) {
        switch rarity {
        case "bizarre", "legendary":
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case "epic":
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        default:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }

    static func achievement() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    static func levelUp() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    static func poseMatch(score: Int) {
        if score >= 95 {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        } else if score >= 75 {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        } else {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }

    static func tap() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
