import SwiftUI

struct JJSurfaceCard: ViewModifier {
    var cornerRadius: CGFloat = 12
    var accent: Color? = nil
    var lineWidth: CGFloat = 1
    var elevation: CGFloat = 8

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.jojoCardBg.opacity(0.92))
            )
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder((accent ?? .white).opacity(accent == nil ? 0.08 : 0.32), lineWidth: lineWidth)
            }
            .shadow(color: (accent ?? .black).opacity(accent == nil ? 0.12 : 0.22), radius: elevation, y: 4)
    }
}

extension View {
    func jjSurfaceCard(
        cornerRadius: CGFloat = 12,
        accent: Color? = nil,
        lineWidth: CGFloat = 1,
        elevation: CGFloat = 8
    ) -> some View {
        modifier(JJSurfaceCard(cornerRadius: cornerRadius, accent: accent, lineWidth: lineWidth, elevation: elevation))
    }
}
