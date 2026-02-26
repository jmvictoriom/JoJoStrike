import SwiftUI

@Observable
@MainActor
final class AppState {
    var selectedTab: AppTab = .training
    var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    var showingPoseChallenge: Bool = false
    var activePoseID: String?

    enum AppTab: Int, CaseIterable {
        case training = 0
        case shop
        case collection
        case profile
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
