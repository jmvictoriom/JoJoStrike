import SwiftUI
import SwiftData

@main
struct JoJoStrikeApp: App {
    @State private var appState = AppState()
    @State private var profileProvider = CurrentProfileProvider()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserAccount.self,
            UserProfile.self,
            PoseAttemptRecord.self,
            OwnedCollectibleCard.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Schema mismatch — delete old store and retry
            let url = modelConfiguration.url
            try? FileManager.default.removeItem(at: url)
            // Also remove WAL/SHM files
            try? FileManager.default.removeItem(at: url.appendingPathExtension("wal"))
            try? FileManager.default.removeItem(at: url.appendingPathExtension("shm"))
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }()

    @State private var authService: LocalAuthService?

    var body: some Scene {
        WindowGroup {
            Group {
                if let authService {
                    Group {
                        if appState.isAuthenticated {
                            if appState.hasCompletedOnboarding {
                                MainTabView()
                            } else {
                                OnboardingView()
                            }
                        } else {
                            AuthContainerView()
                        }
                    }
                    .environment(authService)
                } else {
                    ProgressView()
                }
            }
            .environment(appState)
            .environment(profileProvider)
            .preferredColorScheme(.dark)
            .onAppear {
                let context = sharedModelContainer.mainContext
                if authService == nil {
                    authService = LocalAuthService(modelContext: context)
                }

                TestUserSeeder.seedTestUserIfNeeded(in: context)

                // Restore session
                if let savedID = authService?.currentUserID() {
                    let descriptor = FetchDescriptor<UserAccount>(
                        predicate: #Predicate { $0.id == savedID }
                    )
                    if let account = try? context.fetch(descriptor).first {
                        profileProvider.load(userAccountID: account.id, in: context)
                        appState.loginSucceeded(
                            userAccountID: account.id,
                            onboardingCompleted: account.hasCompletedOnboarding
                        )
                    }
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
