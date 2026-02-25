import SwiftUI

struct RarityBorder: ViewModifier {
    let rarity: CardRarity
    @State private var animationPhase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(borderStyle, lineWidth: rarity.borderWidth)
            }
            .overlay {
                if rarity.hasGlowBorder {
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(rarity.color.opacity(0.4), lineWidth: rarity.borderWidth + 2)
                        .blur(radius: 6)
                        .opacity(rarity == .bizarre ? 0.8 : 0.5)
                }
            }
            .onAppear {
                if rarity.hasHolographicEffect || rarity == .epic {
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                        animationPhase = 1
                    }
                }
            }
    }

    private var startDegrees: Double {
        Double(animationPhase) * 360.0
    }

    private var endDegrees: Double {
        Double(animationPhase) * 360.0 + 360.0
    }

    private var loopedGradientColors: [Color] {
        var colors = rarity.gradientColors
        if let first = colors.first {
            colors.append(first)
        }
        return colors
    }

    private var borderStyle: AnyShapeStyle {
        if rarity == .bizarre {
            AnyShapeStyle(AngularGradient(
                colors: loopedGradientColors,
                center: .center,
                startAngle: .degrees(startDegrees),
                endAngle: .degrees(endDegrees)
            ))
        } else if rarity.gradientColors.count >= 2 {
            AnyShapeStyle(LinearGradient(
                colors: rarity.gradientColors,
                startPoint: UnitPoint(x: animationPhase, y: 0),
                endPoint: UnitPoint(x: 1 - animationPhase, y: 1)
            ))
        } else {
            AnyShapeStyle(rarity.color)
        }
    }
}

extension View {
    func rarityBorder(_ rarity: CardRarity) -> some View {
        modifier(RarityBorder(rarity: rarity))
    }
}
