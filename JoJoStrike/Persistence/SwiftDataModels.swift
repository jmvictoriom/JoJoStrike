import Foundation
import SwiftData

@Model
final class UserProfile {
    var displayName: String
    var level: Int
    var totalXP: Int
    var currentStreak: Int
    var bestStreak: Int
    var lastActiveDate: Date?
    var unlockedPoseIDs: [String]
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var attempts: [PoseAttemptRecord]

    init(
        displayName: String = "Stand User",
        level: Int = 1,
        totalXP: Int = 0
    ) {
        self.displayName = displayName
        self.level = level
        self.totalXP = totalXP
        self.currentStreak = 0
        self.bestStreak = 0
        self.lastActiveDate = nil
        self.unlockedPoseIDs = []
        self.createdAt = Date()
        self.attempts = []
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
