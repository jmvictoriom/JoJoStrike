import Foundation
import SwiftUI

struct PoseAttempt: Identifiable, Sendable {
    let id: UUID
    let poseID: String
    let score: Int
    let medal: Medal
    let date: Date
    let duration: TimeInterval
    let capturedImage: Data?

    init(
        poseID: String,
        score: Int,
        duration: TimeInterval = 0,
        capturedImage: Data? = nil
    ) {
        self.id = UUID()
        self.poseID = poseID
        self.score = score
        self.medal = Medal.from(score: score)
        self.date = Date()
        self.duration = duration
        self.capturedImage = capturedImage
    }

    var isFirstCompletion: Bool { medal >= .bronze }

    var xpEarned: Int {
        guard let pose = PoseDatabase.pose(byID: poseID) else { return 0 }
        let base = medal.baseXPMultiplier * Double(pose.difficulty)
        return Int(base * pose.rarity.xpMultiplier)
    }
}
