import SwiftUI
import SwiftData

@Observable
@MainActor
final class CollectionViewModel {
    var selectedRarity: CardRarity?
    var selectedPart: Int?
    var showUnlockedOnly: Bool = false
    var sortBy: SortOption = .rarity

    enum SortOption: String, CaseIterable {
        case rarity = "Rarity"
        case difficulty = "Difficulty"
        case part = "Part"
        case name = "Name"
    }

    var filteredPoses: [PoseCard] {
        var poses = PoseDatabase.allPoses

        if let rarity = selectedRarity {
            poses = poses.filter { $0.rarity == rarity }
        }
        if let part = selectedPart {
            poses = poses.filter { $0.part == part }
        }

        switch sortBy {
        case .rarity:
            poses.sort { rarityOrder($0.rarity) > rarityOrder($1.rarity) }
        case .difficulty:
            poses.sort { $0.difficulty > $1.difficulty }
        case .part:
            poses.sort { $0.part < $1.part }
        case .name:
            poses.sort { $0.name < $1.name }
        }

        return poses
    }

    func isUnlocked(_ poseID: String, unlockedIDs: [String]) -> Bool {
        unlockedIDs.contains(poseID)
    }

    func collectionProgress(unlockedIDs: [String]) -> (unlocked: Int, total: Int) {
        let total = PoseDatabase.allPoses.count
        let unlocked = PoseDatabase.allPoses.filter { unlockedIDs.contains($0.id) }.count
        return (unlocked, total)
    }

    func progressForPart(_ part: Int, unlockedIDs: [String]) -> Double {
        let partPoses = PoseDatabase.poses(forPart: part)
        guard !partPoses.isEmpty else { return 0 }
        let unlocked = partPoses.filter { unlockedIDs.contains($0.id) }.count
        return Double(unlocked) / Double(partPoses.count)
    }

    var availableParts: [Int] {
        Array(Set(PoseDatabase.allPoses.map(\.part))).sorted()
    }

    func clearFilters() {
        selectedRarity = nil
        selectedPart = nil
        showUnlockedOnly = false
    }

    private func rarityOrder(_ rarity: CardRarity) -> Int {
        switch rarity {
        case .common: 0
        case .rare: 1
        case .epic: 2
        case .legendary: 3
        case .bizarre: 4
        }
    }
}
