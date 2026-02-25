import Foundation

enum AchievementCondition: Sendable, Equatable {
    case completePoses(count: Int)
    case collectAllFromPart(part: Int)
    case platinumOnLegendary
    case platinumOnPose(poseID: String)
    case platinumAll
    case streak(days: Int)
    case unlockRarity(CardRarity)
    case goldOrBetterCount(count: Int, category: PoseCategory?)
    case reachLevel(level: Int)
    case completeBeforeHour(hour: Int)
    case completeAfterHour(hour: Int)
    case goldInSeconds(seconds: Int)
}

struct Achievement: Identifiable, Sendable, Equatable {
    let id: String
    let title: String
    let description: String
    let iconName: String
    let xpReward: Int
    let condition: AchievementCondition

    static func == (lhs: Achievement, rhs: Achievement) -> Bool {
        lhs.id == rhs.id
    }
}
