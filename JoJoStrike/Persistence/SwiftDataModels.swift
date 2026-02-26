import Foundation
import SwiftData

@Model
final class UserProfile {
    var displayName: String
    var level: Int
    var totalXP: Int
    var coins: Int
    var currentStreak: Int
    var bestStreak: Int
    var lastActiveDate: Date?
    var unlockedPoseIDs: [String]
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var attempts: [PoseAttemptRecord]

    @Relationship(deleteRule: .cascade)
    var ownedCards: [OwnedCollectibleCard]

    init(
        displayName: String = "Stand User",
        level: Int = 1,
        totalXP: Int = 0,
        coins: Int = 0
    ) {
        self.displayName = displayName
        self.level = level
        self.totalXP = totalXP
        self.coins = coins
        self.currentStreak = 0
        self.bestStreak = 0
        self.lastActiveDate = nil
        self.unlockedPoseIDs = []
        self.createdAt = Date()
        self.attempts = []
        self.ownedCards = []
    }
}

@Model
final class PoseAttemptRecord {
    var poseID: String
    var score: Int
    var medal: String
    var date: Date
    var photoData: Data?

    @Relationship(inverse: \UserProfile.attempts)
    var profile: UserProfile?

    init(
        poseID: String,
        score: Int,
        medal: String = "none",
        date: Date = Date(),
        photoData: Data? = nil
    ) {
        self.poseID = poseID
        self.score = score
        self.medal = medal
        self.date = date
        self.photoData = photoData
    }
}

@Model
final class OwnedCollectibleCard {
    var cardID: String
    var obtainedDate: Date
    var count: Int

    @Relationship(inverse: \UserProfile.ownedCards)
    var profile: UserProfile?

    init(cardID: String, obtainedDate: Date = Date(), count: Int = 1) {
        self.cardID = cardID
        self.obtainedDate = obtainedDate
        self.count = count
    }
}
