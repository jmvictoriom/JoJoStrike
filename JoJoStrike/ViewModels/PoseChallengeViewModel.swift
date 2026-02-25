import SwiftUI
import SwiftData

@Observable
@MainActor
final class PoseChallengeViewModel {
    let pose: PoseCard
    let detectionService = PoseDetectionService()

    private(set) var currentScore: Int = 0
    private(set) var bestScore: Int = 0
    private(set) var countdown: Int = 3
    private(set) var timeRemaining: Double = 15.0
    private(set) var phase: ChallengePhase = .countdown
    private(set) var matchProgress: Double = 0

    private var timer: Timer?
    private var startTime: Date?

    enum ChallengePhase: Equatable {
        case countdown
        case posing
        case finished(score: Int, medal: Medal)
    }

    init(poseID: String) {
        self.pose = PoseDatabase.pose(byID: poseID) ?? PoseDatabase.allPoses[0]
    }

    func startChallenge() async {
        await detectionService.startSession()
        beginCountdown()
    }

    func stopChallenge() {
        timer?.invalidate()
        timer = nil
        detectionService.stopSession()
    }

    private func beginCountdown() {
        countdown = 3
        phase = .countdown
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }
                self.countdown -= 1
                HapticsService.tap()
                if self.countdown <= 0 {
                    self.timer?.invalidate()
                    self.beginPosing()
                }
            }
        }
    }

    private func beginPosing() {
        phase = .posing
        timeRemaining = 15.0
        startTime = Date()
        bestScore = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 15.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self else { return }

                let elapsed = Date().timeIntervalSince(self.startTime ?? Date())
                self.timeRemaining = max(0, 15.0 - elapsed)

                let score = PoseComparisonService.compare(
                    detected: self.detectionService.detectedJoints,
                    target: self.pose.jointTargets
                )
                self.currentScore = score
                self.matchProgress = Double(score) / 100.0

                if score > self.bestScore {
                    self.bestScore = score
                }

                if self.timeRemaining <= 0 {
                    self.timer?.invalidate()
                    self.finishChallenge()
                }
            }
        }
    }

    private func finishChallenge() {
        detectionService.stopSession()
        let medal = Medal.from(score: bestScore)
        phase = .finished(score: bestScore, medal: medal)
        HapticsService.poseMatch(score: bestScore)
    }

    var xpEarned: Int {
        let medal = Medal.from(score: bestScore)
        let base = medal.baseXPMultiplier * Double(pose.difficulty)
        return Int(base * pose.rarity.xpMultiplier)
    }

    var duration: TimeInterval {
        guard let startTime else { return 0 }
        return Date().timeIntervalSince(startTime)
    }
}
