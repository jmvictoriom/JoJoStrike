import SwiftUI

struct PackOpeningView: View {
    let cards: [CollectibleCard]
    let newCardIDs: Set<String>
    let duplicateRefunds: [String: Int]
    let onDismiss: () -> Void

    @State private var phase: OpeningPhase = .packAppear
    @State private var revealedIndices: Set<Int> = []
    @State private var packScale: CGFloat = 0.5
    @State private var packOpacity: Double = 0
    @State private var cardsAppeared = false
    @State private var showSummary = false

    enum OpeningPhase {
        case packAppear
        case opening
        case revealing
        case summary
    }

    var body: some View {
        ZStack {
            Color.jojoDarkBg.ignoresSafeArea()

            switch phase {
            case .packAppear:
                packView
            case .opening:
                openingAnimation
            case .revealing:
                cardRevealGrid
            case .summary:
                summaryView
            }
        }
        .onAppear { animatePackAppear() }
    }

    // MARK: - Pack View

    private var packView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "shippingbox.fill")
                .font(.system(size: 100))
                .foregroundStyle(.jojoGold.gradient)
                .scaleEffect(packScale)
                .opacity(packOpacity)
                .shadow(color: .jojoGold.opacity(0.3), radius: 20)

            Text("¡Toca para abrir!")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .opacity(packOpacity)

            Spacer()
        }
        .onTapGesture { openPack() }
    }

    // MARK: - Opening Animation

    private var openingAnimation: some View {
        VStack {
            Spacer()

            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundStyle(.jojoGold)
                .symbolEffect(.bounce, options: .repeating)

            Text("ゴゴゴ")
                .font(.system(size: 40, weight: .black))
                .foregroundStyle(.jojoPurple)

            Spacer()
        }
    }

    // MARK: - Card Reveal Grid

    private var cardRevealGrid: some View {
        VStack(spacing: 16) {
            Text("Toca cada carta para revelar")
                .font(.headline)
                .foregroundStyle(.secondary)
                .opacity(revealedIndices.count < cards.count ? 1 : 0)

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                        CardRevealView(
                            card: card,
                            isRevealed: revealedIndices.contains(index),
                            isNew: newCardIDs.contains(card.id),
                            refund: duplicateRefunds[card.id]
                        ) {
                            AudioService.shared.play("card_flip")
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                revealedIndices.insert(index)
                            }
                            HapticsService.cardReveal(rarity: card.rarity.rawValue)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                AudioService.shared.playCardReveal(rarity: card.rarity)
                            }
                        }
                    }
                }
                .padding()
            }

            if revealedIndices.count == cards.count {
                Button {
                    withAnimation { phase = .summary }
                } label: {
                    Text("VER RESUMEN")
                        .font(.headline.bold())
                        .tracking(2)
                        .foregroundStyle(.jojoDarkBg)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.jojoGold.gradient)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 40)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(.top)
    }

    // MARK: - Summary

    private var summaryView: some View {
        VStack(spacing: 20) {
            Text("Resumen")
                .font(.title.bold())
                .foregroundStyle(.jojoGold)

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(Array(cards.enumerated()), id: \.offset) { _, card in
                        let isNew = newCardIDs.contains(card.id)
                        let refund = duplicateRefunds[card.id]

                        HStack {
                            Text(card.starsDisplay)
                                .font(.caption)
                                .foregroundStyle(card.rarity.color)

                            Text(card.characterName)
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)

                            Spacer()

                            if isNew {
                                Text("¡NUEVA!")
                                    .font(.caption.bold())
                                    .foregroundStyle(.green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(.green.opacity(0.2))
                                    .clipShape(Capsule())
                            } else if let refund {
                                HStack(spacing: 2) {
                                    Image(systemName: "dollarsign.circle.fill")
                                        .font(.caption2)
                                    Text("+\(refund)")
                                        .font(.caption.bold())
                                }
                                .foregroundStyle(.jojoGold)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.jojoCardBg)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
            }

            Button(action: onDismiss) {
                Text("CONTINUAR")
                    .font(.headline.bold())
                    .tracking(2)
                    .foregroundStyle(.jojoDarkBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.jojoGold.gradient)
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
    }

    // MARK: - Animations

    private func animatePackAppear() {
        AudioService.shared.play("pack_whoosh")
        withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
            packScale = 1.0
            packOpacity = 1.0
        }
    }

    private func openPack() {
        HapticsService.achievement()
        AudioService.shared.playMenacing()
        withAnimation(.easeIn(duration: 0.3)) {
            phase = .opening
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            AudioService.shared.stopMenacing()
            withAnimation(.spring(response: 0.5)) {
                phase = .revealing
            }
        }
    }
}
