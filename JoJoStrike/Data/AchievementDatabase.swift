import Foundation

struct AchievementDatabase {
    static let allAchievements: [Achievement] = [
        // MARK: - Completion Milestones

        Achievement(
            id: "first-pose",
            title: "Yare Yare Daze!",
            description: "Complete your first pose",
            iconName: "star.fill",
            xpReward: 50,
            condition: .completePoses(count: 1)
        ),
        Achievement(
            id: "ten-poses",
            title: "Muda Muda Muda!",
            description: "Complete 10 poses",
            iconName: "flame.fill",
            xpReward: 150,
            condition: .completePoses(count: 10)
        ),
        Achievement(
            id: "all-poses",
            title: "Ora Ora Ora!",
            description: "Complete all 30 poses",
            iconName: "trophy.fill",
            xpReward: 500,
            condition: .completePoses(count: 30)
        ),

        // MARK: - Part Collectors

        Achievement(
            id: "collector-part1",
            title: "Phantom Blood Collector",
            description: "Unlock all Part 1 cards",
            iconName: "book.closed.fill",
            xpReward: 100,
            condition: .collectAllFromPart(part: 1)
        ),
        Achievement(
            id: "collector-part2",
            title: "Battle Tendency Collector",
            description: "Unlock all Part 2 cards",
            iconName: "book.closed.fill",
            xpReward: 150,
            condition: .collectAllFromPart(part: 2)
        ),
        Achievement(
            id: "collector-part3",
            title: "Stardust Crusaders Collector",
            description: "Unlock all Part 3 cards",
            iconName: "book.closed.fill",
            xpReward: 150,
            condition: .collectAllFromPart(part: 3)
        ),
        Achievement(
            id: "collector-part4",
            title: "Diamond is Unbreakable Collector",
            description: "Unlock all Part 4 cards",
            iconName: "book.closed.fill",
            xpReward: 150,
            condition: .collectAllFromPart(part: 4)
        ),
        Achievement(
            id: "collector-part5",
            title: "Arrivederci!",
            description: "Unlock all Part 5 cards",
            iconName: "book.closed.fill",
            xpReward: 200,
            condition: .collectAllFromPart(part: 5)
        ),
        Achievement(
            id: "collector-part6",
            title: "Stone Ocean Collector",
            description: "Unlock all Part 6 cards",
            iconName: "book.closed.fill",
            xpReward: 150,
            condition: .collectAllFromPart(part: 6)
        ),

        // MARK: - Mastery

        Achievement(
            id: "za-warudo",
            title: "ZA WARUDO!",
            description: "Get Platinum on a Legendary pose",
            iconName: "diamond.fill",
            xpReward: 300,
            condition: .platinumOnLegendary
        ),
        Achievement(
            id: "wryyy-master",
            title: "WRYYYY!",
            description: "Get Platinum on DIO's WRYYY Arch",
            iconName: "bolt.fill",
            xpReward: 250,
            condition: .platinumOnPose(poseID: "dio-wryyy")
        ),
        Achievement(
            id: "requiem",
            title: "This is... Requiem",
            description: "Get Platinum on all 30 poses",
            iconName: "crown.fill",
            xpReward: 1000,
            condition: .platinumAll
        ),

        // MARK: - Streaks

        Achievement(
            id: "streak-3",
            title: "Streak of 3 Days",
            description: "Complete the daily challenge 3 days in a row",
            iconName: "flame.fill",
            xpReward: 75,
            condition: .streak(days: 3)
        ),
        Achievement(
            id: "streak-7",
            title: "Streak of 7 Days",
            description: "Complete the daily challenge 7 days in a row",
            iconName: "flame.fill",
            xpReward: 200,
            condition: .streak(days: 7)
        ),
        Achievement(
            id: "streak-30",
            title: "Giorno's Determination",
            description: "Complete the daily challenge 30 days in a row",
            iconName: "flame.circle.fill",
            xpReward: 500,
            condition: .streak(days: 30)
        ),

        // MARK: - Rarity & Category

        Achievement(
            id: "menacing",
            title: "Menacing ゴゴゴ",
            description: "Unlock a Bizarre card",
            iconName: "sparkles",
            xpReward: 200,
            condition: .unlockRarity(.bizarre)
        ),
        Achievement(
            id: "fashion-icon",
            title: "Fashion Icon",
            description: "Get Gold or better on 15 Fabulous poses",
            iconName: "sparkle",
            xpReward: 300,
            condition: .goldOrBetterCount(count: 15, category: .fabulous)
        ),

        // MARK: - Levels

        Achievement(
            id: "level-25",
            title: "I, Giorno Giovanna, have a dream",
            description: "Reach level 25",
            iconName: "star.circle.fill",
            xpReward: 250,
            condition: .reachLevel(level: 25)
        ),
        Achievement(
            id: "level-50",
            title: "JoJo Pose Master",
            description: "Reach level 50",
            iconName: "crown.fill",
            xpReward: 500,
            condition: .reachLevel(level: 50)
        ),

        // MARK: - Time-based

        Achievement(
            id: "early-bird",
            title: "Morning Pose",
            description: "Complete a pose before 8am",
            iconName: "sunrise.fill",
            xpReward: 75,
            condition: .completeBeforeHour(hour: 8)
        ),
        Achievement(
            id: "night-owl",
            title: "Nocturno Bizarre",
            description: "Complete a pose after midnight",
            iconName: "moon.fill",
            xpReward: 75,
            condition: .completeAfterHour(hour: 0)
        ),
        Achievement(
            id: "speedrun",
            title: "Speedrun",
            description: "Get Gold on a pose in less than 5 seconds",
            iconName: "timer",
            xpReward: 150,
            condition: .goldInSeconds(seconds: 5)
        ),
    ]

    static func achievement(byID id: String) -> Achievement? {
        allAchievements.first { $0.id == id }
    }
}
