import SwiftUI

struct XPProgressBar: View {
    let currentXP: Int
    let requiredXP: Int
    let level: Int
    var barColor: Color = .jojoGold
    var height: CGFloat = 8

    private var progress: Double {
        guard requiredXP > 0 else { return 0 }
        return min(1.0, Double(currentXP) / Double(requiredXP))
    }

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Lv.\(level)")
                    .font(.caption.bold())
                    .foregroundStyle(barColor)

                Spacer()

                Text("\(currentXP)/\(requiredXP) XP")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white.opacity(0.1))
                        .frame(height: height)

                    Capsule()
                        .fill(barColor.gradient)
                        .frame(width: geo.size.width * progress, height: height)
                        .animation(.spring(duration: 0.6), value: progress)
                }
            }
            .frame(height: height)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        XPProgressBar(currentXP: 75, requiredXP: 100, level: 5)
        XPProgressBar(currentXP: 30, requiredXP: 200, level: 12, barColor: .jojoPurple)
    }
    .padding()
    .background(Color.jojoDarkBg)
}
