import Foundation

struct PoseComparisonService: Sendable {
    static func compare(
        detected: [String: CGPoint],
        target: [JointAngleTarget]
    ) -> Int {
        guard !target.isEmpty, detected.count >= 4 else { return 0 }

        var totalScore: Double = 0
        var totalWeight: Double = 0

        for angleTarget in target {
            let angle = computeAngle(for: angleTarget.joint, from: detected)
            guard let angle else { continue }

            let midTarget = (angleTarget.minAngle + angleTarget.maxAngle) / 2.0
            let range = (angleTarget.maxAngle - angleTarget.minAngle) / 2.0

            let diff = abs(angle - midTarget)
            let score: Double
            if diff <= range {
                score = 1.0
            } else {
                score = max(0, 1.0 - (diff - range) / 45.0)
            }

            totalScore += score * angleTarget.weight
            totalWeight += angleTarget.weight
        }

        guard totalWeight > 0 else { return 0 }
        return min(100, Int((totalScore / totalWeight) * 100))
    }

    private static func computeAngle(for joint: String, from joints: [String: CGPoint]) -> Double? {
        switch joint {
        case "leftElbow":
            return angleBetween(a: joints["leftShoulder"], b: joints["leftElbow"], c: joints["leftWrist"])
        case "rightElbow":
            return angleBetween(a: joints["rightShoulder"], b: joints["rightElbow"], c: joints["rightWrist"])
        case "leftShoulder":
            return shoulderAngle(hip: joints["leftHip"], shoulder: joints["leftShoulder"], elbow: joints["leftElbow"])
        case "rightShoulder":
            return shoulderAngle(hip: joints["rightHip"], shoulder: joints["rightShoulder"], elbow: joints["rightElbow"])
        case "leftKnee":
            return angleBetween(a: joints["leftHip"], b: joints["leftKnee"], c: joints["leftAnkle"])
        case "rightKnee":
            return angleBetween(a: joints["rightHip"], b: joints["rightKnee"], c: joints["rightAnkle"])
        case "torsoLean":
            return torsoLeanAngle(from: joints)
        default:
            return nil
        }
    }

    private static func angleBetween(a: CGPoint?, b: CGPoint?, c: CGPoint?) -> Double? {
        guard let a, let b, let c else { return nil }

        let v1 = CGPoint(x: a.x - b.x, y: a.y - b.y)
        let v2 = CGPoint(x: c.x - b.x, y: c.y - b.y)

        let dot = v1.x * v2.x + v1.y * v2.y
        let cross = v1.x * v2.y - v1.y * v2.x

        let angle = atan2(cross, dot)
        return abs(angle * 180.0 / .pi)
    }

    private static func shoulderAngle(hip: CGPoint?, shoulder: CGPoint?, elbow: CGPoint?) -> Double? {
        guard let hip, let shoulder, let elbow else { return nil }

        let torsoDir = CGPoint(x: hip.x - shoulder.x, y: hip.y - shoulder.y)
        let armDir = CGPoint(x: elbow.x - shoulder.x, y: elbow.y - shoulder.y)

        let dot = torsoDir.x * armDir.x + torsoDir.y * armDir.y
        let mag1 = sqrt(torsoDir.x * torsoDir.x + torsoDir.y * torsoDir.y)
        let mag2 = sqrt(armDir.x * armDir.x + armDir.y * armDir.y)

        guard mag1 > 0, mag2 > 0 else { return nil }

        let cosAngle = max(-1, min(1, dot / (mag1 * mag2)))
        return acos(cosAngle) * 180.0 / .pi
    }

    private static func torsoLeanAngle(from joints: [String: CGPoint]) -> Double? {
        let neck = joints["neck"]
        let leftHip = joints["leftHip"]
        let rightHip = joints["rightHip"]

        guard let neck, let leftHip, let rightHip else { return nil }

        let midHip = CGPoint(x: (leftHip.x + rightHip.x) / 2, y: (leftHip.y + rightHip.y) / 2)
        let torsoVec = CGPoint(x: neck.x - midHip.x, y: neck.y - midHip.y)
        let upVec = CGPoint(x: 0, y: -1)

        let dot = torsoVec.x * upVec.x + torsoVec.y * upVec.y
        let mag = sqrt(torsoVec.x * torsoVec.x + torsoVec.y * torsoVec.y)

        guard mag > 0 else { return nil }

        let cosAngle = max(-1, min(1, dot / mag))
        return acos(cosAngle) * 180.0 / .pi
    }
}
