import SwiftUI
import SwiftData

struct ShopView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    @State private var vm = ShopViewModel()

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.jojoDarkBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        coinBalance

                        ForEach(vm.availablePacks) { pack in
                            packCard(pack)
                        }

                        infoSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Tienda")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .fullScreenCover(isPresented: $vm.showPackOpening) {
                PackOpeningView(
                    cards: vm.revealedCards,
                    newCardIDs: vm.newCardIDs,
                    duplicateRefunds: vm.duplicateRefunds
                ) {
                    vm.resetPackOpening()
                }
            }
            .alert("Error", isPresented: .init(
                get: { vm.purchaseError != nil },
                set: { if !$0 { vm.purchaseError = nil } }
            )) {
                Button("OK") { vm.purchaseError = nil }
            } message: {
                Text(vm.purchaseError ?? "")
            }
        }
    }

    // MARK: - Coin Balance

    private var coinBalance: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.largeTitle)
                .foregroundStyle(.jojoGold)

            VStack(alignment: .leading) {
                Text("\(profile?.coins ?? 0)")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundStyle(.jojoGold)
                Text("monedas disponibles")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Pack Card

    private func packCard(_ pack: CardPack) -> some View {
        let canBuy = vm.canAfford(pack, coins: profile?.coins ?? 0)

        return VStack(spacing: 12) {
            HStack {
                Image(systemName: pack.iconName)
                    .font(.title)
                    .foregroundStyle(packColor(pack))

                VStack(alignment: .leading, spacing: 4) {
                    Text(pack.name)
                        .font(.headline.bold())
                        .foregroundStyle(.white)

                    Text(pack.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                Spacer()
            }

            HStack {
                // Card count
                HStack(spacing: 4) {
                    Image(systemName: "rectangle.stack")
                        .font(.caption)
                    Text("\(pack.cardCount) cartas")
                        .font(.caption.bold())
                }
                .foregroundStyle(.secondary)

                if let minRarity = pack.guaranteedMinRarity {
                    HStack(spacing: 4) {
                        Text("•")
                        Text("1 \(minRarity.displayName)+")
                            .font(.caption.bold())
                            .foregroundStyle(minRarity.color)
                    }
                }

                Spacer()

                // Buy button
                Button {
                    if let profile {
                        vm.purchasePack(pack, profile: profile, context: modelContext)
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.caption)
                        Text("\(pack.price)")
                            .font(.headline.bold())
                    }
                    .foregroundStyle(canBuy ? .jojoDarkBg : .gray)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(canBuy ? packColor(pack) : .gray.opacity(0.3))
                    .clipShape(Capsule())
                }
                .disabled(!canBuy || vm.isPurchasing)
            }
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(packColor(pack).opacity(0.3), lineWidth: 1)
        }
    }

    // MARK: - Info

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("¿Cómo ganar monedas?")
                .font(.headline.bold())
                .foregroundStyle(.white)

            infoRow(icon: "figure.martial.arts", text: "Entrena poses para ganar monedas", color: .jojoPurple)
            infoRow(icon: "medal.fill", text: "Mejor medalla = más monedas", color: .jojoGold)
            infoRow(icon: "calendar.badge.clock", text: "Desafío diario da x2 monedas", color: .jojoOrange)
            infoRow(icon: "star.fill", text: "Primera vez completando = +50 bonus", color: .jojoBlue)
        }
        .padding()
        .background(.jojoCardBg)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func infoRow(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func packColor(_ pack: CardPack) -> Color {
        switch pack.id {
        case "basic": .jojoSilver
        case "premium": .jojoBlue
        case "legendary": .jojoGold
        default: .jojoSilver
        }
    }
}

#Preview {
    ShopView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
