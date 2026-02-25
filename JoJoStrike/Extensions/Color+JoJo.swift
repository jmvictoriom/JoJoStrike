import SwiftUI

extension Color {
    // MARK: - Primary Palette

    /// Golden accent - JoJo's iconic gold (#D4AF37)
    static let jojoGold = Color(red: 0.831, green: 0.686, blue: 0.216)

    /// Stand energy purple (#6B3FA0)
    static let jojoPurple = Color(red: 0.420, green: 0.247, blue: 0.627)

    /// DIO's crimson red (#C41E3A)
    static let jojoRed = Color(red: 0.769, green: 0.118, blue: 0.227)

    /// Deep crimson - King Crimson (#8B0000)
    static let jojoCrimson = Color(red: 0.545, green: 0.0, blue: 0.0)

    /// Electric blue - Rare cards, Jotaro theme (#1E90FF)
    static let jojoBlue = Color(red: 0.118, green: 0.565, blue: 1.0)

    /// Silver - Common cards (#C0C0C0)
    static let jojoSilver = Color(red: 0.753, green: 0.753, blue: 0.753)

    /// Part 5 orange (#FF6B35)
    static let jojoOrange = Color(red: 1.0, green: 0.420, blue: 0.208)

    // MARK: - Backgrounds

    /// Main dark background (#0D0D1A)
    static let jojoDarkBg = Color(red: 0.051, green: 0.051, blue: 0.102)

    /// Card background (#1A1A2E)
    static let jojoCardBg = Color(red: 0.102, green: 0.102, blue: 0.180)

    /// Menacing purple for effects (#4A0E4E)
    static let menacingPurple = Color(red: 0.290, green: 0.055, blue: 0.306)

    // MARK: - Rarity Colors

    static let rarityCommon = jojoSilver
    static let rarityRare = jojoBlue
    static let rarityEpic = jojoPurple
    static let rarityLegendary = jojoGold
    static let rarityBizarre = Color(red: 1.0, green: 0.0, blue: 0.5) // Hot pink base for rainbow
}

extension ShapeStyle where Self == Color {
    static var jojoGold: Color { Color.jojoGold }
    static var jojoPurple: Color { Color.jojoPurple }
    static var jojoRed: Color { Color.jojoRed }
    static var jojoCrimson: Color { Color.jojoCrimson }
    static var jojoBlue: Color { Color.jojoBlue }
    static var jojoSilver: Color { Color.jojoSilver }
    static var jojoOrange: Color { Color.jojoOrange }
    static var jojoDarkBg: Color { Color.jojoDarkBg }
    static var jojoCardBg: Color { Color.jojoCardBg }
    static var menacingPurple: Color { Color.menacingPurple }
}
