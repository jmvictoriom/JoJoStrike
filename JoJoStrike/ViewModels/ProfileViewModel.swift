import SwiftUI
import SwiftData

@Observable
@MainActor
final class ProfileViewModel {
    var profile: UserProfile?

    var level: Int {
        guard let profile else { return 1 }
        return GamificationService.levelFromTotalXP(profile.totalXP)
    }

    var title: String {
        GamificationService.title(forLevel: level)
    }

    var xpProgress: (current: Int, required: Int) {
        guard let profile else { return (0, 100) }
        return GamificationService.xpProgressInCurrentLevel(profile.totalXP)
    }

    var totalPosesCompleted: Int {
        guard let profile else { return 0 }
        return Set(profile.attempts.filter { $0.score >= Medal.bronze.minimumScore }.map(\.poseID)).count
    }

    var totalAttempts: Int {
        profile?.attempts.count ?? 0
    }

    var bestScore: Int {
        profile?.attempts.map(\.score).max() ?? 0
    }

    var averageScore: Int {
        guard let profile, !profile.attempts.isEmpty else { return 0 }
        let total = profile.attempts.reduce(0) { $0 + $1.score }
        return total / profile.attempts.count
    }

    var medalCounts: [Medal: Int] {
        guard let profile else { return [:] }
        var counts: [Medal: Int] = [:]
        for attempt in profile.attempts {
            let medal = Medal(rawValue: attempt.medal) ?? .none
            if medal != .none {
                counts[medal, default: 0] += 1
            }
        }
        return counts
    }

    var currentStreak: Int {
        profile?.currentStreak ?? 0
    }

    var bestStreak: Int {
        profile?.bestStreak ?? 0
    }

    var unlockedAchievements: [Achievement] {
        guard let profile else { return [] }
        return AchievementDatabase.allAchievements.filter {
            profile.unlockedPoseIDs.contains("ach_\($0.id)")
        }
    }

    var achievementProgress: (unlocked: Int, total: Int) {
        (unlockedAchievements.count, AchievementDatabase.allAchievements.count)
    }

    var dailyChallenge: PoseCard {
        GamificationService.dailyChallengePose()
    }

    func ensureProfile(in context: ModelContext) {
        let descriptor = FetchDescriptor<UserProfile>()
        let existing = try? context.fetch(descriptor)
        if existing?.isEmpty ?? true {
            let newProfile = UserProfile()
            context.insert(newProfile)
            try? context.save()
            profile = newProfile
        } else {
            profile = existing?.first
        }
    }
}
