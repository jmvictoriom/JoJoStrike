import SwiftUI

struct CardSwipeView: View {
    @State private var viewModel = CardSwipeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    headerBar

                    Spacer()

                    cardStack

                    Spacer()

                    swipeHint

                    Spacer().frame(height: 8)
                }
            }
            .navigationTitle("JoJo Strike")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.spring) { viewModel.shuffleDeck() }
                    } label: {
                        Image(systemName: "shuffle")
                            .foregroundStyle(.jojoGold)
                    }
                }
            }
            .fullScreenCover(item: $viewModel.selectedPoseForChallenge) { card in
                PoseChallengeView(poseID: card.id)
                    .onDisappear { viewModel.dismissChallenge() }
            }
        }
    }

    // MARK: - Header

    private var headerBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.cardsRemaining) cards")
                    .font(.caption.bold())
                    .foregroundStyle(.white)

                ProgressView(value: viewModel.progress)
                    .tint(.jojoGold)
                    .frame(width: 80)
            }

            Spacer()

            HStack(spacing: 12) {
                Label("\(viewModel.swipedRight.count)", systemImage: "star.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.jojoGold)

                Label("\(viewModel.swipedLeft.count)", systemImage: "xmark")
                    .font(.caption.bold())
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Card Stack

    private var cardStack: some View {
        ZStack {
            ForEach(Array(viewModel.upcomingCards.enumerated().reversed()), id: \.element.id) { index, card in
                let isTop = index == 0

                PoseCardView(card: card, onTryPose: isTop ? {
                    viewModel.selectedPoseForChallenge = card
                } : nil)
                .scaleEffect(1.0 - CGFloat(index) * 0.04)
                .offset(y: CGFloat(index) * 8)
                .opacity(index > 2 ? 0 : 1.0 - Double(index) * 0.15)
                .zIndex(Double(viewModel.upcomingCards.count - index))
                .allowsHitTesting(isTop)
                .modifier(
                    isTop
                    ? SwipeGestureModifier { direction in
                        viewModel.swipe(direction)
                    }
                    : SwipeGestureModifier { _ in }
                )
            }

            if viewModel.currentCard == nil {
                emptyState
            }
        }
        .frame(height: 500)
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Text("ゴゴゴ")
                .font(.system(size: 50))
                .foregroundStyle(.jojoGold.opacity(0.2))

            Text("No more cards!")
                .font(.title2.bold())
                .foregroundStyle(.white)

            Button {
                withAnimation(.spring) { viewModel.shuffleDeck() }
            } label: {
                Label("Shuffle Deck", systemImage: "shuffle")
                    .font(.headline)
                    .foregroundStyle(.jojoDarkBg)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.jojoGold.gradient)
                    .clipShape(Capsule())
            }
        }
    }

    // MARK: - Hints

    private var swipeHint: some View {
        HStack(spacing: 40) {
            HStack(spacing: 4) {
                Image(systemName: "arrow.left")
                Text("Skip")
            }
            .font(.caption)
            .foregroundStyle(.gray)

            HStack(spacing: 4) {
                Text("Try")
                Image(systemName: "arrow.right")
            }
            .font(.caption)
            .foregroundStyle(.jojoGold)
        }
    }
}

#Preview {
    CardSwipeView()
}
