import SwiftUI
import SwiftData
import AuthenticationServices

struct AuthContainerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Environment(LocalAuthService.self) private var authService
    @Environment(CurrentProfileProvider.self) private var profileProvider
    @State private var showingRegister = false
    @State private var authVM: AuthViewModel?

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            if let vm = authVM {
                if showingRegister {
                    RegisterView(vm: vm, showingRegister: $showingRegister)
                } else {
                    LoginView(vm: vm, showingRegister: $showingRegister)
                }
            }
        }
        .onAppear {
            if authVM == nil {
                authVM = AuthViewModel(
                    authService: authService,
                    appState: appState,
                    profileProvider: profileProvider
                )
            }
        }
    }
}

// MARK: - Login View

struct LoginView: View {
    @Bindable var vm: AuthViewModel
    @Binding var showingRegister: Bool
    @Environment(\.modelContext) private var modelContext
    @State private var showGoogleAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)

                // Branding
                VStack(spacing: 8) {
                    Text("ゴゴゴ")
                        .font(.system(size: 24))
                        .foregroundStyle(.jojoGold.opacity(0.3))

                    Text("JOJO STRIKE")
                        .font(.system(size: 32, weight: .black))
                        .foregroundStyle(.jojoGold)
                        .tracking(6)

                    Text("ゴゴゴ")
                        .font(.system(size: 24))
                        .foregroundStyle(.jojoGold.opacity(0.3))
                }

                Spacer().frame(height: 20)

                // Form fields
                VStack(spacing: 16) {
                    AuthTextField(
                        text: $vm.username,
                        placeholder: "Usuario",
                        icon: "person.fill"
                    )

                    AuthSecureField(
                        text: $vm.password,
                        placeholder: "Contraseña",
                        icon: "lock.fill"
                    )
                }

                // Error message
                if let error = vm.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.jojoRed)
                        .multilineTextAlignment(.center)
                }

                // Login button
                Button {
                    Task { await vm.login(context: modelContext) }
                } label: {
                    Group {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.jojoDarkBg)
                        } else {
                            Text("INICIAR SESIÓN")
                                .font(.headline.bold())
                                .tracking(2)
                        }
                    }
                    .foregroundStyle(.jojoDarkBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.jojoGold.gradient)
                    .clipShape(Capsule())
                }
                .disabled(vm.isLoading)

                // Divider
                HStack {
                    Rectangle().fill(.gray.opacity(0.3)).frame(height: 1)
                    Text("o continúa con")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Rectangle().fill(.gray.opacity(0.3)).frame(height: 1)
                }

                // Apple Sign-In
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName]
                } onCompletion: { result in
                    Task { await vm.handleAppleSignIn(result, context: modelContext) }
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height: 50)
                .clipShape(Capsule())

                // Google placeholder
                Button {
                    showGoogleAlert = true
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "g.circle.fill")
                            .font(.title2)
                        Text("Continuar con Google")
                            .font(.subheadline.bold())
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(.gray.opacity(0.2))
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(.gray.opacity(0.3), lineWidth: 1))
                }

                // Register link
                Button {
                    vm.clearForm()
                    showingRegister = true
                } label: {
                    HStack(spacing: 4) {
                        Text("¿No tienes cuenta?")
                            .foregroundStyle(.secondary)
                        Text("Regístrate")
                            .foregroundStyle(.jojoGold)
                            .bold()
                    }
                    .font(.subheadline)
                }

                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .alert("Próximamente", isPresented: $showGoogleAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("El inicio de sesión con Google estará disponible próximamente.")
        }
    }
}

// MARK: - Register View

struct RegisterView: View {
    @Bindable var vm: AuthViewModel
    @Binding var showingRegister: Bool
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)

                // Title
                VStack(spacing: 8) {
                    Text("CREAR CUENTA")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.jojoGold)
                        .tracking(4)

                    Text("Únete a la aventura")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer().frame(height: 10)

                // Form fields
                VStack(spacing: 16) {
                    AuthTextField(
                        text: $vm.displayName,
                        placeholder: "Nombre para mostrar",
                        icon: "person.text.rectangle.fill"
                    )

                    AuthTextField(
                        text: $vm.username,
                        placeholder: "Usuario",
                        icon: "person.fill"
                    )

                    AuthSecureField(
                        text: $vm.password,
                        placeholder: "Contraseña",
                        icon: "lock.fill"
                    )

                    AuthSecureField(
                        text: $vm.confirmPassword,
                        placeholder: "Confirmar contraseña",
                        icon: "lock.rotation"
                    )
                }

                // Error
                if let error = vm.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.jojoRed)
                        .multilineTextAlignment(.center)
                }

                // Register button
                Button {
                    Task { await vm.register(context: modelContext) }
                } label: {
                    Group {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.jojoDarkBg)
                        } else {
                            Text("CREAR CUENTA")
                                .font(.headline.bold())
                                .tracking(2)
                        }
                    }
                    .foregroundStyle(.jojoDarkBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.jojoGold.gradient)
                    .clipShape(Capsule())
                }
                .disabled(vm.isLoading)

                // Login link
                Button {
                    vm.clearForm()
                    showingRegister = false
                } label: {
                    HStack(spacing: 4) {
                        Text("¿Ya tienes cuenta?")
                            .foregroundStyle(.secondary)
                        Text("Inicia sesión")
                            .foregroundStyle(.jojoGold)
                            .bold()
                    }
                    .font(.subheadline)
                }

                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

// MARK: - Reusable Components

private struct AuthTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.jojoGold.opacity(0.7))
                .frame(width: 20)
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .foregroundStyle(.white)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct AuthSecureField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.jojoGold.opacity(0.7))
                .frame(width: 20)
            SecureField(placeholder, text: $text)
                .foregroundStyle(.white)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
