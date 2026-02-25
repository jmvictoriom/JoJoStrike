import SwiftUI

struct MenacingText: View {
    var count: Int = 5
    var fontSize: CGFloat = 28
    var color: Color = .jojoPurple
    var intensity: Double = 1.0

    @State private var animating = false

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { index in
                Text("ゴ")
                    .font(.system(size: fontSize * CGFloat.random(in: 0.7...1.3)))
                    .foregroundStyle(color.opacity(0.3 + Double(index) * 0.1))
                    .rotationEffect(.degrees(Double.random(in: -30...30)))
                    .offset(
                        x: offsets[index].x,
                        y: offsets[index].y + (animating ? -10 : 10)
                    )
                    .opacity(animating ? 0.8 * intensity : 0.3 * intensity)
                    .animation(
                        .easeInOut(duration: Double.random(in: 1.5...2.5))
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.2),
                        value: animating
                    )
            }
        }
        .onAppear { animating = true }
    }

    private var offsets: [CGPoint] {
        (0..<count).map { i in
            let angle = Double(i) / Double(count) * .pi * 2
            let radius: CGFloat = 60
            return CGPoint(
                x: cos(angle) * radius,
                y: sin(angle) * radius
            )
        }
    }
}

struct MenacingOverlay: ViewModifier {
    let active: Bool
    let color: Color

    func body(content: Content) -> some View {
        content.overlay {
            if active {
                MenacingText(count: 4, fontSize: 20, color: color, intensity: 0.6)
                    .allowsHitTesting(false)
            }
        }
    }
}

extension View {
    func menacing(active: Bool = true, color: Color = .jojoPurple) -> some View {
        modifier(MenacingOverlay(active: active, color: color))
    }
}

#Preview {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        MenacingText()
    }
}
