import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(CurrentProfileProvider.self) private var profileProvider
    @State private var viewModel = CollectionViewModel()

    private var unlockedIDs: [String] {
        profileProvider.profile?.unlockedPoseIDs ?? []
    }

    private var progress: (unlocked: Int, total: Int) {
        viewModel.collectionProgress(unlockedIDs: unlockedIDs)
    }

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        progressHeader

                        FilterView(
                            selectedRarity: $viewModel.selectedRarity,
                            selectedPart: $viewModel.selectedPart,
                            sortBy: $viewModel.sortBy,
                            availableParts: viewModel.availableParts
                        )

                        cardGrid
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Colección")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if viewModel.selectedRarity != nil || viewModel.selectedPart != nil {
                        Button("Limpiar") {
                            withAnimation { viewModel.clearFilters() }
                        }
                        .foregroundStyle(.jojoGold)
                    }
                }
            }
        }
    }

    // MARK: - Progress Header

    private var progressHeader: some View {
        VStack(spacing: 8) {
            HStack {
                Text("\(progress.unlocked)/\(progress.total)")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundStyle(.jojoGold)

                Text("poses coleccionadas")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(.white.opacity(0.1))
                    Capsule()
                        .fill(.jojoGold.gradient)
                        .frame(width: geo.size.width * CGFloat(progress.unlocked) / max(1, CGFloat(progress.total)))
                }
            }
            .frame(height: 6)

            // Per-part progress
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.availableParts, id: \.self) { part in
                        partProgressChip(part)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    private func partProgressChip(_ part: Int) -> some View {
        let prog = viewModel.progressForPart(part, unlockedIDs: unlockedIDs)
        return VStack(spacing: 2) {
            Text("Part \(part)")
                .font(.caption2.bold())
                .foregroundStyle(prog >= 1.0 ? .jojoGold : .secondary)

            Text("\(Int(prog * 100))%")
                .font(.caption2)
                .foregroundStyle(prog >= 1.0 ? .jojoGold : .white.opacity(0.6))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(prog >= 1.0 ? .jojoGold.opacity(0.15) : .white.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    // MARK: - Card Grid

    private var cardGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(viewModel.filteredPoses) { pose in
                let unlocked = viewModel.isUnlocked(pose.id, unlockedIDs: unlockedIDs)

                NavigationLink {
                    CardDetailView(
                        card: pose,
                        isUnlocked: unlocked,
                        bestMedal: bestMedal(for: pose.id),
                        bestScore: bestScore(for: pose.id)
                    )
                } label: {
                    collectionCard(pose: pose, unlocked: unlocked)
                }
            }
        }
        .padding(.horizontal)
    }

    private func collectionCard(pose: PoseCard, unlocked: Bool) -> some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(unlocked ? pose.rarity.color.opacity(0.15) : .white.opacity(0.03))
                    .frame(height: 120)

                if unlocked {
                    Image(pose.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(8)
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: 30))
                        .foregroundStyle(.gray.opacity(0.3))
                }

                // Rarity stars
                VStack {
                    HStack {
                        Text(pose.starsDisplay)
                            .font(.caption2)
                            .foregroundStyle(unlocked ? pose.rarity.color : .gray.opacity(0.3))
                        Spacer()
                    }
                    Spacer()

                    if unlocked {
                        HStack {
                            Spacer()
                            let medal = bestMedal(for: pose.id)
                            if medal != .none {
                                Text(medal.emoji)
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding(6)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        unlocked ? pose.rarity.color.opacity(0.5) : .gray.opacity(0.1),
                        lineWidth: unlocked ? 1.5 : 0.5
                    )
            }

            Text(unlocked ? pose.name : "???")
                .font(.caption2.bold())
                .foregroundStyle(unlocked ? .white : .gray)
                .lineLimit(1)
        }
    }

    // MARK: - Helpers

    private func bestMedal(for poseID: String) -> Medal {
        guard let profile = profileProvider.profile else { return .none }
        let attempts = profile.attempts.filter { $0.poseID == poseID }
        guard let best = attempts.max(by: { $0.score < $1.score }) else { return .none }
        return Medal(rawValue: best.medal) ?? .none
    }

    private func bestScore(for poseID: String) -> Int {
        guard let profile = profileProvider.profile else { return 0 }
        return profile.attempts.filter { $0.poseID == poseID }.map(\.score).max() ?? 0
    }
}

#Preview {
    CollectionView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
