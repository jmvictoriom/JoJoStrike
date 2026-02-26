import Foundation
import SwiftData

enum AuthMethod: String, Codable {
    case local
    case apple
    case google
}

@Model
final class UserAccount {
    @Attribute(.unique) var id: String
    @Attribute(.unique) var username: String
    var displayName: String
    var authMethodRaw: String
    var appleUserID: String?
    var hasCompletedOnboarding: Bool
    var createdAt: Date

    var authMethod: AuthMethod {
        get { AuthMethod(rawValue: authMethodRaw) ?? .local }
        set { authMethodRaw = newValue.rawValue }
    }

    init(
        id: String = UUID().uuidString,
        username: String,
        displayName: String,
        authMethod: AuthMethod = .local,
        appleUserID: String? = nil,
        hasCompletedOnboarding: Bool = false
    ) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.authMethodRaw = authMethod.rawValue
        self.appleUserID = appleUserID
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.createdAt = Date()
    }
}
