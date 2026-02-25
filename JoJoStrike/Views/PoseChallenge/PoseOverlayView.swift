import SwiftUI

struct PoseOverlayView: View {
    let joints: [String: CGPoint]
    var color: Color = .jojoGold
    var lineWidth: CGFloat = 3

    private let connections: [(String, String)] = [
        ("nose", "neck"),
        ("neck", "leftShoulder"),
        ("neck", "rightShoulder"),
        ("leftShoulder", "leftElbow"),
        ("rightShoulder", "rightElbow"),
        ("leftElbow", "leftWrist"),
        ("rightElbow", "rightWrist"),
        ("neck", "leftHip"),
        ("neck", "rightHip"),
        ("leftHip", "leftKnee"),
        ("rightHip", "rightKnee"),
        ("leftKnee", "leftAnkle"),
        ("rightKnee", "rightAnkle"),
    ]

    var body: some View {
        Canvas { context, size in
            // Draw connections
            for (from, to) in connections {
                guard let p1 = joints[from], let p2 = joints[to] else { continue }

                let start = CGPoint(x: p1.x * size.width, y: p1.y * size.height)
                let end = CGPoint(x: p2.x * size.width, y: p2.y * size.height)

                var path = Path()
                path.move(to: start)
                path.addLine(to: end)

                context.stroke(path, with: .color(color.opacity(0.7)), lineWidth: lineWidth)
            }

            // Draw joints
            for (_, point) in joints {
                let center = CGPoint(x: point.x * size.width, y: point.y * size.height)
                let rect = CGRect(
                    x: center.x - 5,
                    y: center.y - 5,
                    width: 10,
                    height: 10
                )
                context.fill(Circle().path(in: rect), with: .color(color))
                let outerRect = CGRect(
                    x: center.x - 7,
                    y: center.y - 7,
                    width: 14,
                    height: 14
                )
                context.stroke(Circle().path(in: outerRect), with: .color(color.opacity(0.4)), lineWidth: 2)
            }
        }
        .allowsHitTesting(false)
    }
}
