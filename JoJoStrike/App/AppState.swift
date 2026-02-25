import SwiftUI

@Observable
@MainActor
final class AppState {
    var selectedTab: AppTab = .discover
    var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    var showingPoseChallenge: Bool = false
    var activePoseID: String?

    enum AppTab: Int, CaseIterable {
        case discover = 0
        case collection
        case profile
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
}
