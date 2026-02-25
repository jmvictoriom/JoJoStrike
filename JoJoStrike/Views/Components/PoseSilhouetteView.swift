import SwiftUI

struct PoseFigure: Sendable {
    let head: CGPoint
    let neck: CGPoint
    let leftShoulder: CGPoint
    let rightShoulder: CGPoint
    let leftElbow: CGPoint
    let rightElbow: CGPoint
    let leftHand: CGPoint
    let rightHand: CGPoint
    let hip: CGPoint
    let leftKnee: CGPoint
    let rightKnee: CGPoint
    let leftFoot: CGPoint
    let rightFoot: CGPoint

    // Optional extras
    var hasHat: Bool = false
    var headTilt: Double = 0 // degrees
}

struct PoseSilhouetteView: View {
    let poseID: String
    let color: Color
    var lineWidth: CGFloat = 5
    var showGlow: Bool = true

    var body: some View {
        Canvas { context, size in
            guard let figure = PoseFigureDatabase.figure(for: poseID) else { return }

            let scale = { (p: CGPoint) -> CGPoint in
                CGPoint(x: p.x * size.width, y: p.y * size.height)
            }

            // Glow layer
            if showGlow {
                drawFigure(context: context, figure: figure, scale: scale, color: color.opacity(0.3), width: lineWidth + 8, jointRadius: 8)
            }

            // Main figure
            drawFigure(context: context, figure: figure, scale: scale, color: color, width: lineWidth, jointRadius: 5)

            // Head
            let headPos = scale(figure.head)
            let headRadius: CGFloat = size.width * 0.065

            if showGlow {
                let glowRect = CGRect(x: headPos.x - headRadius - 4, y: headPos.y - headRadius - 4, width: (headRadius + 4) * 2, height: (headRadius + 4) * 2)
                context.fill(Circle().path(in: glowRect), with: .color(color.opacity(0.2)))
            }

            let headRect = CGRect(x: headPos.x - headRadius, y: headPos.y - headRadius, width: headRadius * 2, height: headRadius * 2)
            context.stroke(Circle().path(in: headRect), with: .color(color), lineWidth: lineWidth * 0.8)

            // Hat accessory
            if figure.hasHat {
                let hatWidth = headRadius * 2.4
                let hatHeight = headRadius * 0.5
                var hatPath = Path()
                hatPath.move(to: CGPoint(x: headPos.x - hatWidth / 2, y: headPos.y - headRadius * 0.8))
                hatPath.addLine(to: CGPoint(x: headPos.x + hatWidth / 2, y: headPos.y - headRadius * 0.8))
                hatPath.addLine(to: CGPoint(x: headPos.x + hatWidth * 0.3, y: headPos.y - headRadius * 0.8 - hatHeight))
                hatPath.addLine(to: CGPoint(x: headPos.x - hatWidth * 0.3, y: headPos.y - headRadius * 0.8 - hatHeight))
                hatPath.closeSubpath()
                context.fill(hatPath, with: .color(color))
            }
        }
    }

    private func drawFigure(context: GraphicsContext, figure: PoseFigure, scale: (CGPoint) -> CGPoint, color: Color, width: CGFloat, jointRadius: CGFloat) {
        let connections: [(KeyPath<PoseFigure, CGPoint>, KeyPath<PoseFigure, CGPoint>)] = [
            // Torso
            (\.neck, \.hip),
            // Shoulders
            (\.neck, \.leftShoulder),
            (\.neck, \.rightShoulder),
            // Arms
            (\.leftShoulder, \.leftElbow),
            (\.rightShoulder, \.rightElbow),
            (\.leftElbow, \.leftHand),
            (\.rightElbow, \.rightHand),
            // Legs
            (\.hip, \.leftKnee),
            (\.hip, \.rightKnee),
            (\.leftKnee, \.leftFoot),
            (\.rightKnee, \.rightFoot),
        ]

        for (fromKP, toKP) in connections {
            let from = scale(figure[keyPath: fromKP])
            let to = scale(figure[keyPath: toKP])

            var path = Path()
            path.move(to: from)
            path.addLine(to: to)
            context.stroke(path, with: .color(color), style: StrokeStyle(lineWidth: width, lineCap: .round))
        }

        // Draw joint dots
        let joints: [KeyPath<PoseFigure, CGPoint>] = [
            \.leftShoulder, \.rightShoulder, \.leftElbow, \.rightElbow,
            \.leftHand, \.rightHand, \.hip, \.leftKnee, \.rightKnee,
            \.leftFoot, \.rightFoot
        ]

        for jointKP in joints {
            let pos = scale(figure[keyPath: jointKP])
            let rect = CGRect(x: pos.x - jointRadius, y: pos.y - jointRadius, width: jointRadius * 2, height: jointRadius * 2)
            context.fill(Circle().path(in: rect), with: .color(color))
        }
    }
}

// MARK: - Pose Figure Database

struct PoseFigureDatabase {
    static func figure(for poseID: String) -> PoseFigure? {
        figures[poseID]
    }

    // All 30 poses defined as normalized coordinates (0-1)
    // Center X = 0.5, Top Y = 0.0, Bottom Y = 1.0
    static let figures: [String: PoseFigure] = [

        // MARK: - BIZARRE

        // 1. Pillar Men Awakening — arms spread wide, chest out, back arched
        "pillar-men-awakening": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.18),
            leftShoulder: CGPoint(x: 0.35, y: 0.22),
            rightShoulder: CGPoint(x: 0.65, y: 0.22),
            leftElbow: CGPoint(x: 0.15, y: 0.15),
            rightElbow: CGPoint(x: 0.85, y: 0.15),
            leftHand: CGPoint(x: 0.05, y: 0.25),
            rightHand: CGPoint(x: 0.95, y: 0.25),
            hip: CGPoint(x: 0.50, y: 0.50),
            leftKnee: CGPoint(x: 0.38, y: 0.70),
            rightKnee: CGPoint(x: 0.62, y: 0.70),
            leftFoot: CGPoint(x: 0.30, y: 0.92),
            rightFoot: CGPoint(x: 0.70, y: 0.92)
        ),

        // 2. Torture Dance — dynamic dance, one leg kicked, arms flowing
        "torture-dance": PoseFigure(
            head: CGPoint(x: 0.45, y: 0.10),
            neck: CGPoint(x: 0.47, y: 0.18),
            leftShoulder: CGPoint(x: 0.35, y: 0.22),
            rightShoulder: CGPoint(x: 0.60, y: 0.20),
            leftElbow: CGPoint(x: 0.20, y: 0.12),
            rightElbow: CGPoint(x: 0.78, y: 0.28),
            leftHand: CGPoint(x: 0.10, y: 0.05),
            rightHand: CGPoint(x: 0.90, y: 0.18),
            hip: CGPoint(x: 0.48, y: 0.48),
            leftKnee: CGPoint(x: 0.35, y: 0.65),
            rightKnee: CGPoint(x: 0.68, y: 0.55),
            leftFoot: CGPoint(x: 0.30, y: 0.90),
            rightFoot: CGPoint(x: 0.85, y: 0.65)
        ),

        // MARK: - LEGENDARY

        // 3. DIO's WRYYY — back arched dramatically, arms raised
        "dio-wryyy": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.08),
            neck: CGPoint(x: 0.50, y: 0.17),
            leftShoulder: CGPoint(x: 0.36, y: 0.22),
            rightShoulder: CGPoint(x: 0.64, y: 0.22),
            leftElbow: CGPoint(x: 0.22, y: 0.10),
            rightElbow: CGPoint(x: 0.78, y: 0.10),
            leftHand: CGPoint(x: 0.15, y: 0.02),
            rightHand: CGPoint(x: 0.85, y: 0.02),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.38, y: 0.72),
            rightKnee: CGPoint(x: 0.62, y: 0.72),
            leftFoot: CGPoint(x: 0.32, y: 0.93),
            rightFoot: CGPoint(x: 0.68, y: 0.93)
        ),

        // 4. Jotaro's One-Finger — pointing forward with one hand, other in pocket
        "jotaro-verdict": PoseFigure(
            head: CGPoint(x: 0.48, y: 0.10),
            neck: CGPoint(x: 0.48, y: 0.19),
            leftShoulder: CGPoint(x: 0.36, y: 0.23),
            rightShoulder: CGPoint(x: 0.60, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.40),
            rightElbow: CGPoint(x: 0.72, y: 0.32),
            leftHand: CGPoint(x: 0.34, y: 0.52),
            rightHand: CGPoint(x: 0.88, y: 0.28),
            hip: CGPoint(x: 0.48, y: 0.52),
            leftKnee: CGPoint(x: 0.40, y: 0.72),
            rightKnee: CGPoint(x: 0.56, y: 0.72),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.60, y: 0.93),
            hasHat: true
        ),

        // 5. Jonathan's Hand Veil — hand in front of face
        "jonathan-veil": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.37, y: 0.23),
            rightShoulder: CGPoint(x: 0.63, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.15),
            rightElbow: CGPoint(x: 0.70, y: 0.38),
            leftHand: CGPoint(x: 0.45, y: 0.06),
            rightHand: CGPoint(x: 0.75, y: 0.50),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.40, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 6. Giorno's Heart-Window — hand on chest, elegant
        "giorno-heart": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.37, y: 0.23),
            rightShoulder: CGPoint(x: 0.63, y: 0.23),
            leftElbow: CGPoint(x: 0.35, y: 0.35),
            rightElbow: CGPoint(x: 0.72, y: 0.35),
            leftHand: CGPoint(x: 0.48, y: 0.30),
            rightHand: CGPoint(x: 0.80, y: 0.45),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.60, y: 0.70),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.65, y: 0.93)
        ),

        // MARK: - EPIC

        // 7. Joseph's Aerial Breakdance — jumping, limbs spread
        "joseph-breakdance": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.15),
            neck: CGPoint(x: 0.50, y: 0.23),
            leftShoulder: CGPoint(x: 0.36, y: 0.27),
            rightShoulder: CGPoint(x: 0.64, y: 0.27),
            leftElbow: CGPoint(x: 0.18, y: 0.18),
            rightElbow: CGPoint(x: 0.82, y: 0.18),
            leftHand: CGPoint(x: 0.05, y: 0.12),
            rightHand: CGPoint(x: 0.95, y: 0.12),
            hip: CGPoint(x: 0.50, y: 0.48),
            leftKnee: CGPoint(x: 0.30, y: 0.58),
            rightKnee: CGPoint(x: 0.70, y: 0.58),
            leftFoot: CGPoint(x: 0.15, y: 0.72),
            rightFoot: CGPoint(x: 0.85, y: 0.72)
        ),

        // 8. Josuke's Hip-Check Vogue — hip tilted, fist under chin
        "josuke-vogue": PoseFigure(
            head: CGPoint(x: 0.55, y: 0.10),
            neck: CGPoint(x: 0.53, y: 0.19),
            leftShoulder: CGPoint(x: 0.40, y: 0.23),
            rightShoulder: CGPoint(x: 0.66, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.35),
            rightElbow: CGPoint(x: 0.65, y: 0.14),
            leftHand: CGPoint(x: 0.22, y: 0.48),
            rightHand: CGPoint(x: 0.58, y: 0.08),
            hip: CGPoint(x: 0.55, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.65, y: 0.70),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.70, y: 0.93)
        ),

        // 9. Killer Queen's Hazard Triangle — lunge, arms at 90°
        "killer-queen-triangle": PoseFigure(
            head: CGPoint(x: 0.45, y: 0.10),
            neck: CGPoint(x: 0.45, y: 0.19),
            leftShoulder: CGPoint(x: 0.33, y: 0.23),
            rightShoulder: CGPoint(x: 0.57, y: 0.23),
            leftElbow: CGPoint(x: 0.20, y: 0.23),
            rightElbow: CGPoint(x: 0.70, y: 0.10),
            leftHand: CGPoint(x: 0.20, y: 0.10),
            rightHand: CGPoint(x: 0.85, y: 0.10),
            hip: CGPoint(x: 0.45, y: 0.52),
            leftKnee: CGPoint(x: 0.28, y: 0.68),
            rightKnee: CGPoint(x: 0.62, y: 0.72),
            leftFoot: CGPoint(x: 0.15, y: 0.90),
            rightFoot: CGPoint(x: 0.72, y: 0.93)
        ),

        // 10. Polnareff's Impossible Lean — extreme lean to one side
        "polnareff-lean": PoseFigure(
            head: CGPoint(x: 0.30, y: 0.15),
            neck: CGPoint(x: 0.33, y: 0.23),
            leftShoulder: CGPoint(x: 0.25, y: 0.28),
            rightShoulder: CGPoint(x: 0.42, y: 0.25),
            leftElbow: CGPoint(x: 0.15, y: 0.38),
            rightElbow: CGPoint(x: 0.55, y: 0.18),
            leftHand: CGPoint(x: 0.10, y: 0.48),
            rightHand: CGPoint(x: 0.65, y: 0.10),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.45, y: 0.72),
            rightKnee: CGPoint(x: 0.60, y: 0.70),
            leftFoot: CGPoint(x: 0.40, y: 0.93),
            rightFoot: CGPoint(x: 0.65, y: 0.93)
        ),

        // 11. Jolyne's Stone Ocean Ensemble — reclined dramatic
        "jolyne-ensemble": PoseFigure(
            head: CGPoint(x: 0.40, y: 0.12),
            neck: CGPoint(x: 0.42, y: 0.20),
            leftShoulder: CGPoint(x: 0.30, y: 0.24),
            rightShoulder: CGPoint(x: 0.55, y: 0.22),
            leftElbow: CGPoint(x: 0.18, y: 0.18),
            rightElbow: CGPoint(x: 0.68, y: 0.32),
            leftHand: CGPoint(x: 0.08, y: 0.10),
            rightHand: CGPoint(x: 0.78, y: 0.42),
            hip: CGPoint(x: 0.48, y: 0.50),
            leftKnee: CGPoint(x: 0.38, y: 0.70),
            rightKnee: CGPoint(x: 0.62, y: 0.65),
            leftFoot: CGPoint(x: 0.30, y: 0.90),
            rightFoot: CGPoint(x: 0.72, y: 0.85)
        ),

        // 12. Lisa Lisa's Face Frame — arms framing face
        "lisa-lisa-frame": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.12),
            neck: CGPoint(x: 0.50, y: 0.20),
            leftShoulder: CGPoint(x: 0.38, y: 0.24),
            rightShoulder: CGPoint(x: 0.62, y: 0.24),
            leftElbow: CGPoint(x: 0.30, y: 0.14),
            rightElbow: CGPoint(x: 0.70, y: 0.14),
            leftHand: CGPoint(x: 0.38, y: 0.06),
            rightHand: CGPoint(x: 0.62, y: 0.06),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // MARK: - RARE

        // 13. Koichi's Great Days Squat — deep squat, arms extended
        "koichi-squat": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.20),
            neck: CGPoint(x: 0.50, y: 0.28),
            leftShoulder: CGPoint(x: 0.38, y: 0.32),
            rightShoulder: CGPoint(x: 0.62, y: 0.32),
            leftElbow: CGPoint(x: 0.22, y: 0.28),
            rightElbow: CGPoint(x: 0.78, y: 0.28),
            leftHand: CGPoint(x: 0.10, y: 0.22),
            rightHand: CGPoint(x: 0.90, y: 0.22),
            hip: CGPoint(x: 0.50, y: 0.55),
            leftKnee: CGPoint(x: 0.32, y: 0.65),
            rightKnee: CGPoint(x: 0.68, y: 0.65),
            leftFoot: CGPoint(x: 0.30, y: 0.85),
            rightFoot: CGPoint(x: 0.70, y: 0.85)
        ),

        // 14. Caesar's Bubble Launcher — arms crossed elevated
        "caesar-bubble": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.38, y: 0.23),
            rightShoulder: CGPoint(x: 0.62, y: 0.23),
            leftElbow: CGPoint(x: 0.55, y: 0.15),
            rightElbow: CGPoint(x: 0.45, y: 0.15),
            leftHand: CGPoint(x: 0.65, y: 0.08),
            rightHand: CGPoint(x: 0.35, y: 0.08),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 15. Kars' Self-Cradle — self-hug, crossed arms on body
        "kars-cradle": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.08),
            neck: CGPoint(x: 0.50, y: 0.17),
            leftShoulder: CGPoint(x: 0.37, y: 0.22),
            rightShoulder: CGPoint(x: 0.63, y: 0.22),
            leftElbow: CGPoint(x: 0.58, y: 0.32),
            rightElbow: CGPoint(x: 0.42, y: 0.32),
            leftHand: CGPoint(x: 0.65, y: 0.22),
            rightHand: CGPoint(x: 0.35, y: 0.22),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 16. Rohan's I Refuse — angular stance, fingers extended
        "rohan-refuse": PoseFigure(
            head: CGPoint(x: 0.52, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.37, y: 0.23),
            rightShoulder: CGPoint(x: 0.63, y: 0.23),
            leftElbow: CGPoint(x: 0.25, y: 0.18),
            rightElbow: CGPoint(x: 0.75, y: 0.30),
            leftHand: CGPoint(x: 0.12, y: 0.10),
            rightHand: CGPoint(x: 0.90, y: 0.22),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.40, y: 0.72),
            rightKnee: CGPoint(x: 0.60, y: 0.70),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.65, y: 0.93)
        ),

        // 17. Stroheim's Cyborg Victory — pelvic thrust, arms up
        "stroheim-victory": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.08),
            neck: CGPoint(x: 0.50, y: 0.17),
            leftShoulder: CGPoint(x: 0.36, y: 0.22),
            rightShoulder: CGPoint(x: 0.64, y: 0.22),
            leftElbow: CGPoint(x: 0.25, y: 0.12),
            rightElbow: CGPoint(x: 0.75, y: 0.12),
            leftHand: CGPoint(x: 0.20, y: 0.02),
            rightHand: CGPoint(x: 0.80, y: 0.02),
            hip: CGPoint(x: 0.52, y: 0.50),
            leftKnee: CGPoint(x: 0.38, y: 0.70),
            rightKnee: CGPoint(x: 0.65, y: 0.70),
            leftFoot: CGPoint(x: 0.30, y: 0.93),
            rightFoot: CGPoint(x: 0.70, y: 0.93)
        ),

        // 18. Johnny & Gyro Point — pointing forward
        "johnny-gyro-point": PoseFigure(
            head: CGPoint(x: 0.45, y: 0.10),
            neck: CGPoint(x: 0.46, y: 0.19),
            leftShoulder: CGPoint(x: 0.34, y: 0.23),
            rightShoulder: CGPoint(x: 0.58, y: 0.23),
            leftElbow: CGPoint(x: 0.25, y: 0.35),
            rightElbow: CGPoint(x: 0.72, y: 0.20),
            leftHand: CGPoint(x: 0.20, y: 0.48),
            rightHand: CGPoint(x: 0.92, y: 0.15),
            hip: CGPoint(x: 0.48, y: 0.52),
            leftKnee: CGPoint(x: 0.40, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 19. Kakyoin's WSJ Cover — angular stance with aura
        "kakyoin-cover": PoseFigure(
            head: CGPoint(x: 0.48, y: 0.10),
            neck: CGPoint(x: 0.48, y: 0.19),
            leftShoulder: CGPoint(x: 0.36, y: 0.23),
            rightShoulder: CGPoint(x: 0.60, y: 0.23),
            leftElbow: CGPoint(x: 0.24, y: 0.30),
            rightElbow: CGPoint(x: 0.72, y: 0.15),
            leftHand: CGPoint(x: 0.15, y: 0.40),
            rightHand: CGPoint(x: 0.82, y: 0.08),
            hip: CGPoint(x: 0.48, y: 0.52),
            leftKnee: CGPoint(x: 0.38, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.32, y: 0.93),
            rightFoot: CGPoint(x: 0.64, y: 0.93)
        ),

        // 20. Bucciarati's Zipper Stance — elegant, arm extended
        "bucciarati-zipper": PoseFigure(
            head: CGPoint(x: 0.48, y: 0.10),
            neck: CGPoint(x: 0.48, y: 0.19),
            leftShoulder: CGPoint(x: 0.36, y: 0.23),
            rightShoulder: CGPoint(x: 0.60, y: 0.23),
            leftElbow: CGPoint(x: 0.28, y: 0.35),
            rightElbow: CGPoint(x: 0.75, y: 0.25),
            leftHand: CGPoint(x: 0.22, y: 0.48),
            rightHand: CGPoint(x: 0.90, y: 0.20),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.60, y: 0.70),
            leftFoot: CGPoint(x: 0.36, y: 0.93),
            rightFoot: CGPoint(x: 0.66, y: 0.93)
        ),

        // MARK: - COMMON

        // 21. Speedwagon's Hat Tip — tipping hat
        "speedwagon-hat": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.38, y: 0.23),
            rightShoulder: CGPoint(x: 0.62, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.35),
            rightElbow: CGPoint(x: 0.62, y: 0.13),
            leftHand: CGPoint(x: 0.25, y: 0.48),
            rightHand: CGPoint(x: 0.55, y: 0.05),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93),
            hasHat: true
        ),

        // 22. Iggy's Cool Sit — sitting with attitude
        "iggy-sit": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.22),
            neck: CGPoint(x: 0.50, y: 0.30),
            leftShoulder: CGPoint(x: 0.40, y: 0.34),
            rightShoulder: CGPoint(x: 0.60, y: 0.34),
            leftElbow: CGPoint(x: 0.32, y: 0.45),
            rightElbow: CGPoint(x: 0.68, y: 0.45),
            leftHand: CGPoint(x: 0.28, y: 0.55),
            rightHand: CGPoint(x: 0.72, y: 0.55),
            hip: CGPoint(x: 0.50, y: 0.58),
            leftKnee: CGPoint(x: 0.35, y: 0.72),
            rightKnee: CGPoint(x: 0.65, y: 0.72),
            leftFoot: CGPoint(x: 0.32, y: 0.88),
            rightFoot: CGPoint(x: 0.68, y: 0.88)
        ),

        // 23. Okuyasu's Oi Josuke — pointing surprised
        "okuyasu-oi": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.38, y: 0.23),
            rightShoulder: CGPoint(x: 0.62, y: 0.23),
            leftElbow: CGPoint(x: 0.28, y: 0.32),
            rightElbow: CGPoint(x: 0.78, y: 0.18),
            leftHand: CGPoint(x: 0.22, y: 0.42),
            rightHand: CGPoint(x: 0.92, y: 0.12),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 24. Avdol's YES I AM — arms crossed firmly
        "avdol-yes": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.37, y: 0.23),
            rightShoulder: CGPoint(x: 0.63, y: 0.23),
            leftElbow: CGPoint(x: 0.55, y: 0.33),
            rightElbow: CGPoint(x: 0.45, y: 0.33),
            leftHand: CGPoint(x: 0.62, y: 0.25),
            rightHand: CGPoint(x: 0.38, y: 0.25),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 25. Narancia's Dance Move — casual dance step
        "narancia-dance": PoseFigure(
            head: CGPoint(x: 0.48, y: 0.10),
            neck: CGPoint(x: 0.48, y: 0.19),
            leftShoulder: CGPoint(x: 0.36, y: 0.23),
            rightShoulder: CGPoint(x: 0.60, y: 0.23),
            leftElbow: CGPoint(x: 0.22, y: 0.28),
            rightElbow: CGPoint(x: 0.72, y: 0.18),
            leftHand: CGPoint(x: 0.12, y: 0.35),
            rightHand: CGPoint(x: 0.80, y: 0.10),
            hip: CGPoint(x: 0.50, y: 0.50),
            leftKnee: CGPoint(x: 0.38, y: 0.68),
            rightKnee: CGPoint(x: 0.65, y: 0.62),
            leftFoot: CGPoint(x: 0.32, y: 0.90),
            rightFoot: CGPoint(x: 0.75, y: 0.78)
        ),

        // 26. Mista's Gun Pose — aiming with relaxed stance
        "mista-gun": PoseFigure(
            head: CGPoint(x: 0.45, y: 0.10),
            neck: CGPoint(x: 0.46, y: 0.19),
            leftShoulder: CGPoint(x: 0.34, y: 0.23),
            rightShoulder: CGPoint(x: 0.58, y: 0.23),
            leftElbow: CGPoint(x: 0.28, y: 0.35),
            rightElbow: CGPoint(x: 0.72, y: 0.22),
            leftHand: CGPoint(x: 0.22, y: 0.45),
            rightHand: CGPoint(x: 0.88, y: 0.18),
            hip: CGPoint(x: 0.48, y: 0.52),
            leftKnee: CGPoint(x: 0.40, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.70),
            leftFoot: CGPoint(x: 0.35, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.90),
            hasHat: true
        ),

        // 27. Trish's Fashion Stance — fashion/runway pose
        "trish-fashion": PoseFigure(
            head: CGPoint(x: 0.52, y: 0.10),
            neck: CGPoint(x: 0.51, y: 0.19),
            leftShoulder: CGPoint(x: 0.39, y: 0.23),
            rightShoulder: CGPoint(x: 0.63, y: 0.23),
            leftElbow: CGPoint(x: 0.32, y: 0.38),
            rightElbow: CGPoint(x: 0.70, y: 0.35),
            leftHand: CGPoint(x: 0.38, y: 0.50),
            rightHand: CGPoint(x: 0.75, y: 0.45),
            hip: CGPoint(x: 0.52, y: 0.52),
            leftKnee: CGPoint(x: 0.45, y: 0.72),
            rightKnee: CGPoint(x: 0.55, y: 0.70),
            leftFoot: CGPoint(x: 0.42, y: 0.93),
            rightFoot: CGPoint(x: 0.52, y: 0.93)
        ),

        // 28. Weather Report's Cool Stand — mysterious standing
        "weather-stand": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.38, y: 0.23),
            rightShoulder: CGPoint(x: 0.62, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.35),
            rightElbow: CGPoint(x: 0.70, y: 0.35),
            leftHand: CGPoint(x: 0.28, y: 0.48),
            rightHand: CGPoint(x: 0.72, y: 0.48),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93),
            hasHat: true
        ),

        // 29. Hermes' Fist Pump — fist raised high
        "hermes-fist": PoseFigure(
            head: CGPoint(x: 0.50, y: 0.10),
            neck: CGPoint(x: 0.50, y: 0.19),
            leftShoulder: CGPoint(x: 0.38, y: 0.23),
            rightShoulder: CGPoint(x: 0.62, y: 0.23),
            leftElbow: CGPoint(x: 0.30, y: 0.35),
            rightElbow: CGPoint(x: 0.70, y: 0.12),
            leftHand: CGPoint(x: 0.25, y: 0.48),
            rightHand: CGPoint(x: 0.72, y: 0.02),
            hip: CGPoint(x: 0.50, y: 0.52),
            leftKnee: CGPoint(x: 0.42, y: 0.72),
            rightKnee: CGPoint(x: 0.58, y: 0.72),
            leftFoot: CGPoint(x: 0.38, y: 0.93),
            rightFoot: CGPoint(x: 0.62, y: 0.93)
        ),

        // 30. Emporio's Scared Run — running away scared
        "emporio-run": PoseFigure(
            head: CGPoint(x: 0.55, y: 0.12),
            neck: CGPoint(x: 0.52, y: 0.20),
            leftShoulder: CGPoint(x: 0.42, y: 0.24),
            rightShoulder: CGPoint(x: 0.62, y: 0.24),
            leftElbow: CGPoint(x: 0.30, y: 0.18),
            rightElbow: CGPoint(x: 0.72, y: 0.32),
            leftHand: CGPoint(x: 0.22, y: 0.10),
            rightHand: CGPoint(x: 0.80, y: 0.40),
            hip: CGPoint(x: 0.50, y: 0.50),
            leftKnee: CGPoint(x: 0.35, y: 0.65),
            rightKnee: CGPoint(x: 0.65, y: 0.62),
            leftFoot: CGPoint(x: 0.25, y: 0.82),
            rightFoot: CGPoint(x: 0.78, y: 0.78)
        ),
    ]
}

#Preview("DIO WRYYY") {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        PoseSilhouetteView(poseID: "dio-wryyy", color: .jojoGold)
            .frame(width: 250, height: 300)
    }
}

#Preview("Jotaro") {
    ZStack {
        Color.jojoDarkBg.ignoresSafeArea()
        PoseSilhouetteView(poseID: "jotaro-verdict", color: .jojoPurple)
            .frame(width: 250, height: 300)
    }
}
