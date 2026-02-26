import Foundation

struct CardPack: Identifiable, Sendable {
    let id: String
    let name: String
    let description: String
    let price: Int
    let cardCount: Int
    let guaranteedMinRarity: CardRarity?
    let iconName: String

    static let allPacks: [CardPack] = [
        CardPack(
            id: "basic",
            name: "Sobre Básico",
            description: "3 cartas aleatorias. Ideal para empezar tu colección.",
            price: 100,
            cardCount: 3,
            guaranteedMinRarity: nil,
            iconName: "shippingbox"
        ),
        CardPack(
            id: "premium",
            name: "Sobre Premium",
            description: "5 cartas con 1 rara o mejor garantizada.",
            price: 300,
            cardCount: 5,
            guaranteedMinRarity: .rare,
            iconName: "shippingbox.fill"
        ),
        CardPack(
            id: "legendary",
            name: "Sobre Legendario",
            description: "5 cartas con 1 épica o mejor garantizada.",
            price: 500,
            cardCount: 5,
            guaranteedMinRarity: .epic,
            iconName: "star.circle.fill"
        )
    ]
}
