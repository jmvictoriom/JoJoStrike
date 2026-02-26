import Foundation
import SwiftData
import CryptoKit

enum TestUserSeeder {
    private static let seededKey = "testUserSeeded"

    @MainActor
    static func seedTestUserIfNeeded(in context: ModelContext) {
        guard !UserDefaults.standard.bool(forKey: seededKey) else { return }

        let descriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.username == "test" }
        )
        guard (try? context.fetch(descriptor))?.isEmpty ?? true else {
            UserDefaults.standard.set(true, forKey: seededKey)
            return
        }

        // Create account
        let account = UserAccount(
            username: "test",
            displayName: "Test User",
            authMethod: .local,
            hasCompletedOnboarding: true
        )
        context.insert(account)

        // Store password "test" in Keychain via the same scheme LocalAuthService uses
        storeTestPassword(forUsername: "test")

        // Calculate total XP for level 50
        var totalXP = 0
        for level in 1..<50 {
            totalXP += GamificationService.xpRequired(forLevel: level)
        }

        // Create maxed-out profile
        let profile = UserProfile(
            userAccountID: account.id,
            displayName: "Test User",
            level: 50,
            totalXP: totalXP,
            coins: 999_999
        )
        profile.currentStreak = 30
        profile.bestStreak = 30

        // Unlock all poses
        let allPoseIDs = PoseDatabase.allPoses.map(\.id)
        profile.unlockedPoseIDs = allPoseIDs

        // Unlock all achievements (stored as "ach_<id>")
        let achievementIDs = AchievementDatabase.allAchievements.map { "ach_\($0.id)" }
        profile.unlockedPoseIDs.append(contentsOf: achievementIDs)

        context.insert(profile)

        // Create platinum attempt records for each pose
        for poseID in allPoseIDs {
            let attempt = PoseAttemptRecord(
                poseID: poseID,
                score: 98,
                medal: Medal.platinum.rawValue
            )
            profile.attempts.append(attempt)
        }

        // Create all collectible cards with count 3
        for card in CollectibleCardDatabase.allCards {
            let owned = OwnedCollectibleCard(cardID: card.id, count: 3)
            profile.ownedCards.append(owned)
        }

        try? context.save()
        UserDefaults.standard.set(true, forKey: seededKey)
    }

    // MARK: - Store test password using same Keychain scheme

    private struct TestCredential: Codable {
        let salt: String
        let hashedPassword: String
    }

    private static func storeTestPassword(forUsername username: String) {
        let salt = "testsalt1234567890abcdef01234567"
        let input = "test" + salt
        let digest = SHA256.hash(data: Data(input.utf8))
        let hashed = digest.map { String(format: "%02x", $0) }.joined()

        let credential = TestCredential(salt: salt, hashedPassword: hashed)

        guard let data = try? JSONEncoder().encode(credential) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "pwd_\(username)",
            kSecAttrService as String: "com.jojostrike.auth",
        ]
        SecItemDelete(query as CFDictionary)

        var addQuery = query
        addQuery[kSecValueData as String] = data
        SecItemAdd(addQuery as CFDictionary, nil)
    }
}
