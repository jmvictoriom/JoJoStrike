import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
    var speed: CGFloat
    var angle: Double
}

struct ParticleEffect: View {
    let rarity: CardRarity
    let particleCount: Int

    @State private var particles: [Particle] = []
    @State private var tick: Bool = false

    init(rarity: CardRarity, particleCount: Int = 12) {
        self.rarity = rarity
        self.particleCount = particleCount
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            Canvas { context, size in
                for particle in particles {
                    let rect = CGRect(
                        x: particle.x - particle.size / 2,
                        y: particle.y - particle.size / 2,
                        width: particle.size,
                        height: particle.size
                    )
                    context.opacity = particle.opacity
                    context.fill(
                        Circle().path(in: rect),
                        with: .color(particleColor(for: particle))
                    )
                }
            }
            .onChange(of: timeline.date) {
                updateParticles()
            }
        }
        .onAppear {
            particles = (0..<particleCount).map { _ in makeParticle() }
        }
        .allowsHitTesting(false)
    }

    private func makeParticle() -> Particle {
        Particle(
            x: CGFloat.random(in: 0...350),
            y: CGFloat.random(in: 0...500),
            size: CGFloat.random(in: 2...6),
            opacity: Double.random(in: 0.2...0.7),
            speed: CGFloat.random(in: 0.5...2.0),
            angle: Double.random(in: 0...(2 * .pi))
        )
    }

    private func updateParticles() {
        particles = particles.map { p in
            var updated = p
            updated.y -= p.speed
            updated.x += sin(p.angle) * 0.5
            updated.opacity = max(0, p.opacity - 0.005)
            if updated.y < -10 || updated.opacity <= 0 {
                return makeParticle()
            }
            return updated
        }
    }

    private func particleColor(for particle: Particle) -> Color {
        switch rarity {
        case .bizarre:
            [Color.jojoRed, .jojoPurple, .jojoBlue, .jojoGold, .jojoOrange]
                .randomElement() ?? .jojoGold
        case .legendary:
            [Color.jojoGold, .jojoRed].randomElement() ?? .jojoGold
        case .epic:
            .jojoPurple.opacity(0.8)
        default:
            rarity.color.opacity(0.5)
        }
    }
}
