import SwiftUI
import SwiftData
import AuthenticationServices

@Observable
@MainActor
final class AuthViewModel {
    var username = ""
    var password = ""
    var confirmPassword = ""
    var displayName = ""
    var isLoading = false
    var errorMessage: String?

    private let authService: LocalAuthService
    private let appState: AppState
    private let profileProvider: CurrentProfileProvider

    init(authService: LocalAuthService, appState: AppState, profileProvider: CurrentProfileProvider) {
        self.authService = authService
        self.appState = appState
        self.profileProvider = profileProvider
    }

    func login(context modelContext: ModelContext) async {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Completa todos los campos"
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let result = try await authService.login(username: username, password: password)
            profileProvider.load(userAccountID: result.userAccountID, in: modelContext)
            appState.loginSucceeded(userAccountID: result.userAccountID, onboardingCompleted: result.hasCompletedOnboarding)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func register(context modelContext: ModelContext) async {
        guard !username.isEmpty, !displayName.isEmpty, !password.isEmpty else {
            errorMessage = "Completa todos los campos"
            return
        }
        guard password == confirmPassword else {
            errorMessage = AuthError.passwordsDoNotMatch.localizedDescription
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let result = try await authService.register(username: username, displayName: displayName, password: password)
            profileProvider.load(userAccountID: result.userAccountID, in: modelContext)
            appState.loginSucceeded(userAccountID: result.userAccountID, onboardingCompleted: result.hasCompletedOnboarding)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func handleAppleSignIn(_ result: Result<ASAuthorization, Error>, context modelContext: ModelContext) async {
        isLoading = true
        errorMessage = nil
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = AuthError.appleSignInFailed.localizedDescription
                isLoading = false
                return
            }
            let userID = credential.user
            let fullName = [credential.fullName?.givenName, credential.fullName?.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            do {
                let authResult = try await authService.loginWithApple(
                    userID: userID,
                    fullName: fullName.isEmpty ? nil : fullName
                )
                profileProvider.load(userAccountID: authResult.userAccountID, in: modelContext)
                appState.loginSucceeded(
                    userAccountID: authResult.userAccountID,
                    onboardingCompleted: authResult.hasCompletedOnboarding
                )
            } catch {
                errorMessage = error.localizedDescription
            }
        case .failure:
            errorMessage = AuthError.appleSignInFailed.localizedDescription
        }
        isLoading = false
    }

    func clearForm() {
        username = ""
        password = ""
        confirmPassword = ""
        displayName = ""
        errorMessage = nil
    }
}
