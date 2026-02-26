import SwiftUI
import SwiftData

@Observable
@MainActor
final class TrainingViewModel {
    var searchText: String = ""
    var selectedCategory: PoseCategory?
    var selectedDifficulty: Int?

    var filteredPoses: [PoseCard] {
        var poses = PoseDatabase.allPoses

        if let category = selectedCategory {
            poses = poses.filter { $0.category == category }
        }
        if let difficulty = selectedDifficulty {
            poses = poses.filter { $0.difficulty == difficulty }
        }
        if !searchText.isEmpty {
            poses = poses.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.character.localizedCaseInsensitiveContains(searchText)
            }
        }

        return poses.sorted { $0.difficulty < $1.difficulty }
    }

    var dailyChallenge: PoseCard {
        GamificationService.dailyChallengePose()
    }

    func bestMedal(for poseID: String, profile: UserProfile?) -> Medal {
        guard let profile else { return .none }
        let attempts = profile.attempts.filter { $0.poseID == poseID }
        guard let best = attempts.max(by: { $0.score < $1.score }) else { return .none }
        return Medal(rawValue: best.medal) ?? .none
    }

    func bestScore(for poseID: String, profile: UserProfile?) -> Int {
        guard let profile else { return 0 }
        return profile.attempts.filter { $0.poseID == poseID }.map(\.score).max() ?? 0
    }

    func isFirstCompletion(for poseID: String, profile: UserProfile?) -> Bool {
        guard let profile else { return true }
        return !profile.attempts.contains { $0.poseID == poseID && $0.score >= Medal.bronze.minimumScore }
    }

    func potentialCoins(for pose: PoseCard) -> Int {
        CoinService.coinsEarned(medal: .gold, difficulty: pose.difficulty, isDailyChallenge: false, isFirstCompletion: false)
    }

    func clearFilters() {
        selectedCategory = nil
        selectedDifficulty = nil
        searchText = ""
    }
}
