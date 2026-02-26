import Foundation
import SwiftData
import CryptoKit

// MARK: - Keychain Helper

private enum KeychainHelper {
    static func save(data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.jojostrike.auth",
        ]
        SecItemDelete(query as CFDictionary)

        var addQuery = query
        addQuery[kSecValueData as String] = data
        SecItemAdd(addQuery as CFDictionary, nil)
    }

    static func load(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.jojostrike.auth",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }

    static func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "com.jojostrike.auth",
        ]
        SecItemDelete(query as CFDictionary)
    }
}

// MARK: - Password Hasher

private enum PasswordHasher {
    static func hash(password: String, salt: String) -> String {
        let input = password + salt
        let digest = SHA256.hash(data: Data(input.utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }

    static func generateSalt() -> String {
        let bytes = (0..<16).map { _ in UInt8.random(in: 0...255) }
        return bytes.map { String(format: "%02x", $0) }.joined()
    }
}

// MARK: - Stored Credential

private struct StoredCredential: Codable {
    let salt: String
    let hashedPassword: String
}

// MARK: - LocalAuthService

@Observable
@MainActor
final class LocalAuthService: AuthServiceProtocol {
    private let modelContext: ModelContext
    private static let sessionKey = "currentUserAccountID"

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func login(username: String, password: String) async throws -> AuthResult {
        let descriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.username == username }
        )
        guard let account = try modelContext.fetch(descriptor).first else {
            throw AuthError.userNotFound
        }

        guard verifyPassword(password, forUsername: username) else {
            throw AuthError.wrongPassword
        }

        persistSession(accountID: account.id)

        return AuthResult(
            userAccountID: account.id,
            displayName: account.displayName,
            authMethod: account.authMethod,
            isNewUser: false,
            hasCompletedOnboarding: account.hasCompletedOnboarding
        )
    }

    func register(username: String, displayName: String, password: String) async throws -> AuthResult {
        guard password.count >= 6 else { throw AuthError.passwordTooShort }

        let descriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.username == username }
        )
        let existing = try modelContext.fetch(descriptor)
        guard existing.isEmpty else { throw AuthError.usernameTaken }

        let account = UserAccount(
            username: username,
            displayName: displayName,
            authMethod: .local
        )
        modelContext.insert(account)

        let profile = UserProfile(userAccountID: account.id, displayName: displayName, coins: 100)
        modelContext.insert(profile)

        try modelContext.save()

        storePassword(password, forUsername: username)
        persistSession(accountID: account.id)

        return AuthResult(
            userAccountID: account.id,
            displayName: displayName,
            authMethod: .local,
            isNewUser: true,
            hasCompletedOnboarding: false
        )
    }

    func loginWithApple(userID: String, fullName: String?) async throws -> AuthResult {
        let descriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.appleUserID == userID }
        )

        if let existing = try modelContext.fetch(descriptor).first {
            persistSession(accountID: existing.id)
            return AuthResult(
                userAccountID: existing.id,
                displayName: existing.displayName,
                authMethod: .apple,
                isNewUser: false,
                hasCompletedOnboarding: existing.hasCompletedOnboarding
            )
        }

        let name = fullName ?? "Stand User"
        let username = "apple_\(userID.prefix(8))_\(Int.random(in: 1000...9999))"
        let account = UserAccount(
            username: username,
            displayName: name,
            authMethod: .apple,
            appleUserID: userID
        )
        modelContext.insert(account)

        let profile = UserProfile(userAccountID: account.id, displayName: name, coins: 100)
        modelContext.insert(profile)

        try modelContext.save()
        persistSession(accountID: account.id)

        return AuthResult(
            userAccountID: account.id,
            displayName: name,
            authMethod: .apple,
            isNewUser: true,
            hasCompletedOnboarding: false
        )
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: Self.sessionKey)
    }

    func currentUserID() -> String? {
        UserDefaults.standard.string(forKey: Self.sessionKey)
    }

    // MARK: - Private

    private func persistSession(accountID: String) {
        UserDefaults.standard.set(accountID, forKey: Self.sessionKey)
    }

    private func storePassword(_ password: String, forUsername username: String) {
        let salt = PasswordHasher.generateSalt()
        let hashed = PasswordHasher.hash(password: password, salt: salt)
        let credential = StoredCredential(salt: salt, hashedPassword: hashed)
        if let data = try? JSONEncoder().encode(credential) {
            KeychainHelper.save(data: data, forKey: "pwd_\(username)")
        }
    }

    private func verifyPassword(_ password: String, forUsername username: String) -> Bool {
        guard let data = KeychainHelper.load(forKey: "pwd_\(username)"),
              let credential = try? JSONDecoder().decode(StoredCredential.self, from: data) else {
            return false
        }
        let hashed = PasswordHasher.hash(password: password, salt: credential.salt)
        return hashed == credential.hashedPassword
    }
}
