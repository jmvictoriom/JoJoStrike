import SwiftUI
import SwiftData

@Observable
@MainActor
final class AppState {
    var selectedTab: AppTab = .training
    var isAuthenticated: Bool = false
    var currentUserAccountID: String?
    var hasCompletedOnboarding: Bool = false
    var showingPoseChallenge: Bool = false
    var activePoseID: String?

    enum AppTab: Int, CaseIterable {
        case training = 0
        case shop
        case collection
        case profile
    }

    func loginSucceeded(userAccountID: String, onboardingCompleted: Bool) {
        currentUserAccountID = userAccountID
        isAuthenticated = true
        hasCompletedOnboarding = onboardingCompleted
    }

    func logout() {
        isAuthenticated = false
        currentUserAccountID = nil
        hasCompletedOnboarding = false
        selectedTab = .training
    }

    func completeOnboarding(in context: ModelContext) {
        hasCompletedOnboarding = true
        guard let accountID = currentUserAccountID else { return }
        let descriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.id == accountID }
        )
        if let account = try? context.fetch(descriptor).first {
            account.hasCompletedOnboarding = true
            try? context.save()
        }
    }
}
