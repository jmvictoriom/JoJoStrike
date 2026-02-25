import SwiftUI
import SwiftData

@main
struct JoJoStrikeApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(appState)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [
            UserProfile.self,
            PoseAttemptRecord.self
        ])
    }
}
