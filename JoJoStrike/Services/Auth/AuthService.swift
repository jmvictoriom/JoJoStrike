import Foundation

enum AuthError: LocalizedError {
    case userNotFound
    case wrongPassword
    case usernameTaken
    case passwordTooShort
    case passwordsDoNotMatch
    case appleSignInFailed
    case unknown

    var errorDescription: String? {
        switch self {
        case .userNotFound: "Usuario no encontrado"
        case .wrongPassword: "Contraseña incorrecta"
        case .usernameTaken: "Ese nombre de usuario ya existe"
        case .passwordTooShort: "La contraseña debe tener al menos 6 caracteres"
        case .passwordsDoNotMatch: "Las contraseñas no coinciden"
        case .appleSignInFailed: "Error al iniciar sesión con Apple"
        case .unknown: "Error desconocido"
        }
    }
}

struct AuthResult {
    let userAccountID: String
    let displayName: String
    let authMethod: AuthMethod
    let isNewUser: Bool
    let hasCompletedOnboarding: Bool
}

@MainActor
protocol AuthServiceProtocol: Observable {
    func login(username: String, password: String) async throws -> AuthResult
    func register(username: String, displayName: String, password: String) async throws -> AuthResult
    func loginWithApple(userID: String, fullName: String?) async throws -> AuthResult
    func logout()
    func currentUserID() -> String?
}
