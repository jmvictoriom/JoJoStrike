import Foundation
import SwiftData

@MainActor
struct CoinService {

    static func coinsEarned(
        medal: Medal,
        difficulty: Int,
        isDailyChallenge: Bool,
        isFirstCompletion: Bool
    ) -> Int {
        guard medal != .none else { return 0 }

        let baseCoins: Double
        switch medal {
        case .none: baseCoins = 0
        case .bronze: baseCoins = 10
        case .silver: baseCoins = 20
        case .gold: baseCoins = 40
        case .platinum: baseCoins = 80
        }

        var total = baseCoins * (1.0 + 0.1 * Double(difficulty))

        if isDailyChallenge {
            total *= 2.0
        }

        if isFirstCompletion {
            total += 50
        }

        return Int(total)
    }

    static func awardCoins(_ amount: Int, to profile: UserProfile) {
        profile.coins += amount
    }

    static func deductCoins(_ amount: Int, from profile: UserProfile) -> Bool {
        guard profile.coins >= amount else { return false }
        profile.coins -= amount
        return true
    }

    static func duplicateRefund(for rarity: CardRarity) -> Int {
        switch rarity {
        case .common: 5
        case .rare: 10
        case .epic: 20
        case .legendary: 40
        case .bizarre: 80
        }
    }
}
