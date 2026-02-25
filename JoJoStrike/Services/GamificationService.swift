import Foundation
import SwiftData

@MainActor
struct GamificationService {
    // MARK: - XP Calculation

    static func calculateXP(
        pose: PoseCard,
        medal: Medal,
        isFirstCompletion: Bool,
        isDailyChallenge: Bool
    ) -> Int {
        guard medal != .none else { return 0 }

        var xp = medal.baseXPMultiplier * Double(pose.difficulty) * pose.rarity.xpMultiplier

        if isFirstCompletion {
            xp *= 1.5
        }
        if isDailyChallenge {
            xp *= 2.0
        }

        return Int(xp)
    }

    // MARK: - Levels

    static func xpRequired(forLevel level: Int) -> Int {
        // Smooth exponential curve: starts at 100, grows ~15% per level
        Int(100.0 * pow(1.15, Double(level - 1)))
    }

    static func levelFromTotalXP(_ totalXP: Int) -> Int {
        var level = 1
        var xpNeeded = 0
        while level < 50 {
            xpNeeded += xpRequired(forLevel: level)
            if totalXP < xpNeeded { break }
            level += 1
        }
        return level
    }

    static func xpProgressInCurrentLevel(_ totalXP: Int) -> (current: Int, required: Int) {
        var remaining = totalXP
        var level = 1
        while level < 50 {
            let needed = xpRequired(forLevel: level)
            if remaining < needed {
                return (remaining, needed)
            }
            remaining -= needed
            level += 1
        }
        return (remaining, xpRequired(forLevel: 50))
    }

    // MARK: - Level Titles

    static func title(forLevel level: Int) -> String {
        switch level {
        case 1...5: "Stand User Novato"
        case 6...10: "Joestar en Entrenamiento"
        case 11...20: "Stand User"
        case 21...30: "Pillar Man"
        case 31...40: "Stand Master"
        case 41...49: "DIO's Rival"
        case 50: "JoJo Pose Master"
        default: "Stand User"
        }
    }

    // MARK: - Streaks

    static func updateStreak(profile: UserProfile) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastActive = profile.lastActiveDate {
            let lastDay = calendar.startOfDay(for: lastActive)
            let diff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0

            if diff == 1 {
                profile.currentStreak += 1
            } else if diff > 1 {
                profile.currentStreak = 1
            }
        } else {
            profile.currentStreak = 1
        }

        profile.bestStreak = max(profile.bestStreak, profile.currentStreak)
        profile.lastActiveDate = Date()
    }

    // MARK: - Streak Bonus

    static func streakBonus(currentStreak: Int) -> Int {
        if currentStreak >= 7 { return 100 }
        return 0
    }

    // MARK: - Achievement Checking

    static func checkAchievements(
        profile: UserProfile
    ) -> [Achievement] {
        var newlyUnlocked: [Achievement] = []
        let completedPoseIDs = Set(profile.attempts.filter { $0.score >= Medal.bronze.minimumScore }.map(\.poseID))
        let level = levelFromTotalXP(profile.totalXP)

        for achievement in AchievementDatabase.allAchievements {
            guard !profile.unlockedPoseIDs.contains("ach_\(achievement.id)") else { continue }

            let earned: Bool
            switch achievement.condition {
            case .completePoses(let count):
                earned = completedPoseIDs.count >= count
            case .collectAllFromPart(let part):
                let partPoses = PoseDatabase.poses(forPart: part)
                earned = partPoses.allSatisfy { completedPoseIDs.contains($0.id) }
            case .platinumOnLegendary:
                earned = profile.attempts.contains { attempt in
                    attempt.score >= Medal.platinum.minimumScore &&
                    PoseDatabase.pose(byID: attempt.poseID)?.rarity == .legendary
                }
            case .platinumOnPose(let poseID):
                earned = profile.attempts.contains { $0.poseID == poseID && $0.score >= Medal.platinum.minimumScore }
            case .platinumAll:
                earned = PoseDatabase.allPoses.allSatisfy { pose in
                    profile.attempts.contains { $0.poseID == pose.id && $0.score >= Medal.platinum.minimumScore }
                }
            case .streak(let days):
                earned = profile.bestStreak >= days
            case .unlockRarity(let rarity):
                earned = profile.attempts.contains { attempt in
                    attempt.score >= Medal.bronze.minimumScore &&
                    PoseDatabase.pose(byID: attempt.poseID)?.rarity == rarity
                }
            case .goldOrBetterCount(let count, let category):
                let matching = profile.attempts.filter { attempt in
                    attempt.score >= Medal.gold.minimumScore &&
                    (category == nil || PoseDatabase.pose(byID: attempt.poseID)?.category == category)
                }
                earned = Set(matching.map(\.poseID)).count >= count
            case .reachLevel(let lvl):
                earned = level >= lvl
            case .completeBeforeHour(let hour):
                earned = profile.attempts.contains {
                    Calendar.current.component(.hour, from: $0.date) < hour
                }
            case .completeAfterHour(let hour):
                earned = profile.attempts.contains {
                    Calendar.current.component(.hour, from: $0.date) >= hour || Calendar.current.component(.hour, from: $0.date) < 4
                }
            case .goldInSeconds(_):
                // Needs duration tracking - skip for now
                earned = false
            }

            if earned {
                newlyUnlocked.append(achievement)
            }
        }

        return newlyUnlocked
    }

    // MARK: - Daily Challenge

    static func dailyChallengePose() -> PoseCard {
        let calendar = Calendar.current
        let day = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let index = day % PoseDatabase.allPoses.count
        return PoseDatabase.allPoses[index]
    }
}
