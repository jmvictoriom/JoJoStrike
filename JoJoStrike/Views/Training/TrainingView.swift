import SwiftUI
import SwiftData

struct TrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(CurrentProfileProvider.self) private var profileProvider
    @State private var vm = TrainingViewModel()
    @State private var selectedPoseID: String?

    private var profile: UserProfile? { profileProvider.profile }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        coinHeader

                        dailyChallengeSection

                        filterBar

                        poseList
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Entrenar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $vm.searchText, prompt: "Buscar pose...")
            .fullScreenCover(item: $selectedPoseID) { poseID in
                PoseChallengeView(poseID: poseID)
            }
        }
    }

    // MARK: - Coin Header

    private var coinHeader: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.title2)
                .foregroundStyle(.jojoGold)
            Text("\(profile?.coins ?? 0)")
                .font(.title2.bold())
                .foregroundStyle(.jojoGold)
            Text("monedas")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: - Daily Challenge

    private var dailyChallengeSection: some View {
        let daily = vm.dailyChallenge
        let medal = vm.bestMedal(for: daily.id, profile: profile)

        return Button {
            selectedPoseID = daily.id
        } label: {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundStyle(.jojoOrange)
                    Text("Desafío Diario")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                    Spacer()
                    Text("x2 Monedas")
                        .font(.caption.bold())
                        .foregroundStyle(.jojoOrange)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.jojoOrange.opacity(0.2))
                        .clipShape(Capsule())
                }

                HStack(spacing: 12) {
                    Image(daily.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(daily.name)
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                        Text(daily.partDisplay)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        HStack(spacing: 4) {
                            Text(daily.difficultyDisplay)
                                .font(.caption)
                            if medal != .none {
                                Text(medal.emoji)
                                    .font(.caption)
                            }
                        }
                    }

                    Spacer()

                    Image(systemName: "play.circle.fill")
                        .font(.title)
                        .foregroundStyle(.jojoOrange)
                }
            }
            .padding()
            .background(.jojoCardBg)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.jojoOrange.opacity(0.3), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }

    // MARK: - Filters

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(PoseCategory.allCases) { category in
                    Button {
                        withAnimation {
                            vm.selectedCategory = vm.selectedCategory == category ? nil : category
                        }
                    } label: {
                        Text("\(category.emoji) \(category.displayName)")
                            .font(.caption.bold())
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(vm.selectedCategory == category ? .jojoGold.opacity(0.3) : .white.opacity(0.05))
                            .foregroundStyle(vm.selectedCategory == category ? .jojoGold : .white)
                            .clipShape(Capsule())
                    }
                }

                if vm.selectedCategory != nil {
                    Button {
                        withAnimation { vm.clearFilters() }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Pose List

    private var poseList: some View {
        LazyVStack(spacing: 8) {
            ForEach(vm.filteredPoses) { pose in
                TrainingPoseRow(
                    pose: pose,
                    medal: vm.bestMedal(for: pose.id, profile: profile),
                    potentialCoins: vm.potentialCoins(for: pose)
                ) {
                    selectedPoseID = pose.id
                }
            }
        }
        .padding(.horizontal)
    }
}

extension String: @retroactive Identifiable {
    public var id: String { self }
}

#Preview {
    TrainingView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
