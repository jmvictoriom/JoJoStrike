import SwiftUI

struct OnboardingView: View {
    @Environment(AppState.self) private var appState
    @State private var currentPage = 0

    private let pages: [(icon: String, title: String, subtitle: String, color: Color)] = [
        ("rectangle.stack.fill", "DISCOVER", "Swipe through iconic JoJo poses\nfrom every Part", .jojoGold),
        ("camera.viewfinder", "STRIKE A POSE", "Use your camera to replicate\nlegendary JoJo poses", .jojoRed),
        ("trophy.fill", "COLLECT & MASTER", "Earn medals, level up, and unlock\nall 30 pose cards", .jojoPurple),
        ("flame.fill", "DAILY CHALLENGE", "Complete a new pose every day\nand build your streak", .jojoOrange),
    ]

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            VStack(spacing: 0) {
                // ゴゴゴ header
                Text("ゴゴゴ")
                    .font(.system(size: 30))
                    .foregroundStyle(.jojoGold.opacity(0.2))
                    .padding(.top, 40)

                // Title
                Text("JOJO STRIKE")
                    .font(.system(size: 36, weight: .black))
                    .foregroundStyle(.jojoGold)
                    .tracking(8)
                    .padding(.top, 8)

                Spacer()

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        onboardingPage(page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 320)

                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? pages[currentPage].color : .gray.opacity(0.3))
                            .frame(width: index == currentPage ? 10 : 6, height: index == currentPage ? 10 : 6)
                            .animation(.spring(response: 0.3), value: currentPage)
                    }
                }
                .padding(.top, 20)

                Spacer()

                // Actions
                VStack(spacing: 12) {
                    if currentPage == pages.count - 1 {
                        Button {
                            appState.completeOnboarding()
                        } label: {
                            Text("LET'S GO!")
                                .font(.headline.bold())
                                .tracking(2)
                                .foregroundStyle(.jojoDarkBg)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(.jojoGold.gradient)
                                .clipShape(Capsule())
                        }
                    } else {
                        Button {
                            withAnimation { currentPage += 1 }
                        } label: {
                            Text("NEXT")
                                .font(.headline.bold())
                                .tracking(2)
                                .foregroundStyle(.jojoDarkBg)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(pages[currentPage].color.gradient)
                                .clipShape(Capsule())
                        }
                    }

                    if currentPage < pages.count - 1 {
                        Button {
                            appState.completeOnboarding()
                        } label: {
                            Text("Skip")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
    }

    private func onboardingPage(_ page: (icon: String, title: String, subtitle: String, color: Color)) -> some View {
        VStack(spacing: 20) {
            Image(systemName: page.icon)
                .font(.system(size: 70))
                .foregroundStyle(page.color)
                .shadow(color: page.color.opacity(0.4), radius: 20)

            Text(page.title)
                .font(.system(size: 24, weight: .black))
                .foregroundStyle(.white)
                .tracking(4)

            Text(page.subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    OnboardingView()
        .environment(AppState())
}
