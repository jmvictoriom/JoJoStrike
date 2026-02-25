import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var profiles: [UserProfile]

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    // Avatar placeholder
                    Circle()
                        .fill(.jojoGold.gradient)
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.jojoDarkBg)
                        }

                    Text("STAND USER")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.jojoGold)
                        .tracking(6)

                    if let profile {
                        VStack(spacing: 8) {
                            Text("Level \(profile.level)")
                                .font(.title2.bold())
                                .foregroundStyle(.white)

                            Text("\(profile.totalXP) XP")
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        Text("Level 1")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
