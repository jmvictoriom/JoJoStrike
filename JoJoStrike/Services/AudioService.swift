import AVFoundation

@MainActor
final class AudioService {
    static let shared = AudioService()

    private var players: [String: AVAudioPlayer] = [:]
    private var menacingPlayer: AVAudioPlayer?
    private var activePlayers: [AVAudioPlayer] = []

    private init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AudioService: Failed to configure audio session: \(error)")
        }
    }

    // MARK: - Play

    func play(_ name: String) {
        guard let url = urlFor(name) else { return }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            activePlayers.removeAll { !$0.isPlaying }
            activePlayers.append(player)
        } catch {
            print("AudioService: Failed to play \(name): \(error)")
        }
    }

    // MARK: - Stand Cries

    func playStandCry(for poseID: String) {
        let cryName = standCry(for: poseID)
        play("stand_cries/\(cryName)")
    }

    private func standCry(for poseID: String) -> String {
        let id = poseID.lowercased()

        if id.hasPrefix("jotaro") { return "ora_ora" }
        if id.hasPrefix("dio") { return "wryyy" }
        if id.hasPrefix("giorno") { return "muda_muda" }
        if id.hasPrefix("josuke") { return "dora_dora" }
        if id.hasPrefix("bucciarati") { return "arrivederci" }
        if id.hasPrefix("kakyoin") { return "emerald_splash" }
        if id.hasPrefix("killer-queen") { return "za_warudo" }
        if id.hasPrefix("pillar-men") { return "ayaya" }
        if id.hasPrefix("jonathan") { return "ora_ora" }
        if id.hasPrefix("joseph") { return "ora_ora" }
        if id.hasPrefix("jolyne") { return "ora_ora" }
        if id.hasPrefix("polnareff") { return "ora_ora" }
        if id.hasPrefix("torture-dance") { return "arrivederci" }

        // Fallback: generic impact
        return "ora_ora"
    }

    // MARK: - Card Reveal

    func playCardReveal(rarity: CardRarity) {
        switch rarity {
        case .common:    play("reveal_common")
        case .rare:      play("reveal_rare")
        case .epic:      play("reveal_epic")
        case .legendary: play("reveal_legendary")
        case .bizarre:   play("reveal_bizarre")
        }
    }

    // MARK: - Menacing Loop

    func playMenacing() {
        guard let url = urlFor("menacing") else { return }

        do {
            menacingPlayer = try AVAudioPlayer(contentsOf: url)
            menacingPlayer?.numberOfLoops = -1
            menacingPlayer?.volume = 0.6
            menacingPlayer?.prepareToPlay()
            menacingPlayer?.play()
        } catch {
            print("AudioService: Failed to play menacing loop: \(error)")
        }
    }

    func stopMenacing() {
        menacingPlayer?.stop()
        menacingPlayer = nil
    }

    // MARK: - Preload

    func preload(_ names: [String]) {
        for name in names {
            guard let url = urlFor(name), players[name] == nil else { continue }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                players[name] = player
            } catch {
                print("AudioService: Failed to preload \(name): \(error)")
            }
        }
    }

    // MARK: - Helpers

    private func urlFor(_ name: String) -> URL? {
        // Try with the name as-is (might include subdirectory)
        let components = name.split(separator: "/")
        let fileName: String
        let subdir: String?

        if components.count == 2 {
            subdir = String(components[0])
            fileName = String(components[1])
        } else {
            subdir = nil
            fileName = name
        }

        if let subdir {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "wav", subdirectory: "Sounds/\(subdir)") {
                return url
            }
            // Fallback: try without subdirectory structure
            return Bundle.main.url(forResource: fileName, withExtension: "wav")
        }

        if let url = Bundle.main.url(forResource: fileName, withExtension: "wav", subdirectory: "Sounds") {
            return url
        }
        return Bundle.main.url(forResource: fileName, withExtension: "wav")
    }
}
