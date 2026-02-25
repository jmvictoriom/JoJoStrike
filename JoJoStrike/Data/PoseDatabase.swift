import Foundation

struct PoseDatabase {

    static let allPoses: [PoseCard] = [

        // MARK: - Bizarre

        PoseCard(
            id: "pillar-men-awakening",
            name: "Pillar Men Awakening",
            character: "Kars/Esidisi/Wamuu",
            part: 2,
            partName: "Battle Tendency",
            description: "The ancient Pillar Men strike their legendary awakening pose in unison, flexing with divine confidence.",
            difficulty: 5,
            category: .menacing,
            rarity: .bizarre,
            iconicPhrase: "AYAYAYAYYY!",
            imageName: "pose_pillar-men-awakening",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 160, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 90, max: 120, weight: 1.0),
                JointAngleTarget("rightElbow", min: 100, max: 130, weight: 0.8),
                JointAngleTarget("leftElbow", min: 80, max: 110, weight: 0.8),
                JointAngleTarget("torsoLean", min: 95, max: 115, weight: 1.0),
                JointAngleTarget("rightKnee", min: 150, max: 175, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "torture-dance",
            name: "Torture Dance",
            character: "Bucciarati Gang",
            part: 5,
            partName: "Golden Wind",
            description: "Narancia, Mista, and Fugo perform the iconic rhythmic torture dance with synchronized flair.",
            difficulty: 5,
            category: .fabulous,
            rarity: .bizarre,
            iconicPhrase: "Vocal percussion on a whole 'nother level!",
            imageName: "pose_torture-dance",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 130, max: 160, weight: 1.0),
                JointAngleTarget("rightElbow", min: 60, max: 90, weight: 0.8),
                JointAngleTarget("leftElbow", min: 90, max: 120, weight: 0.8),
                JointAngleTarget("rightKnee", min: 100, max: 130, weight: 1.0),
                JointAngleTarget("torsoLean", min: 75, max: 90, weight: 0.7)
            ]
        ),

        // MARK: - Legendary

        PoseCard(
            id: "dio-wryyy",
            name: "DIO's WRYYY Arch",
            character: "DIO",
            part: 3,
            partName: "Stardust Crusaders",
            description: "DIO arches his back dramatically with both arms raised, channeling pure vampiric dominance.",
            difficulty: 4,
            category: .menacing,
            rarity: .legendary,
            iconicPhrase: "¡Inútil! ¡INÚTIL!",
            imageName: "pose_dio-wryyy",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("rightElbow", min: 130, max: 165, weight: 0.7),
                JointAngleTarget("leftElbow", min: 130, max: 165, weight: 0.7),
                JointAngleTarget("torsoLean", min: 100, max: 125, weight: 1.0)
            ]
        ),

        PoseCard(
            id: "jotaro-verdict",
            name: "Jotaro's One-Finger Verdict",
            character: "Jotaro Kujo",
            part: 3,
            partName: "Stardust Crusaders",
            description: "Jotaro points a single finger forward with cold confidence, delivering his verdict.",
            difficulty: 2,
            category: .menacing,
            rarity: .legendary,
            iconicPhrase: "Yare yare daze...",
            imageName: "pose_jotaro-verdict",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 70, max: 100, weight: 1.0),
                JointAngleTarget("rightElbow", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 0, max: 20, weight: 0.7),
                JointAngleTarget("torsoLean", min: 85, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "jonathan-veil",
            name: "Jonathan's Hand Veil",
            character: "Jonathan Joestar",
            part: 1,
            partName: "Phantom Blood",
            description: "Jonathan raises one hand dramatically before his face, partially veiling his determined expression.",
            difficulty: 3,
            category: .dramatic,
            rarity: .legendary,
            iconicPhrase: "I reject my humanity!",
            imageName: "pose_jonathan-veil",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 120, max: 150, weight: 1.0),
                JointAngleTarget("rightElbow", min: 40, max: 70, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 20, max: 50, weight: 0.7),
                JointAngleTarget("leftElbow", min: 80, max: 120, weight: 0.5),
                JointAngleTarget("torsoLean", min: 85, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "giorno-heart",
            name: "Giorno's Heart-Window",
            character: "Giorno Giovanna",
            part: 5,
            partName: "Golden Wind",
            description: "Giorno forms a heart-shaped window over his chest with both hands, framing his resolve.",
            difficulty: 3,
            category: .fabulous,
            rarity: .legendary,
            iconicPhrase: "I, Giorno Giovanna, have a dream.",
            imageName: "pose_giorno-heart",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("rightElbow", min: 40, max: 70, weight: 1.0),
                JointAngleTarget("leftElbow", min: 40, max: 70, weight: 1.0),
                JointAngleTarget("torsoLean", min: 85, max: 95, weight: 0.5)
            ]
        ),

        // MARK: - Epic

        PoseCard(
            id: "joseph-breakdance",
            name: "Joseph's Aerial Breakdance",
            character: "Joseph Joestar",
            part: 2,
            partName: "Battle Tendency",
            description: "Joseph launches into an acrobatic breakdance-style kick with arms spread wide.",
            difficulty: 5,
            category: .battle,
            rarity: .epic,
            iconicPhrase: "Your next line is...",
            imageName: "pose_joseph-breakdance",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("rightKnee", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftKnee", min: 150, max: 180, weight: 0.8),
                JointAngleTarget("torsoLean", min: 60, max: 80, weight: 0.7)
            ]
        ),

        PoseCard(
            id: "josuke-vogue",
            name: "Josuke's Hip-Check Vogue",
            character: "Josuke Higashikata",
            part: 4,
            partName: "Diamond is Unbreakable",
            description: "Josuke pops his hip to the side with one hand behind his head in a vogue-style stance.",
            difficulty: 3,
            category: .fabulous,
            rarity: .epic,
            iconicPhrase: "What did you say about my hair?!",
            imageName: "pose_josuke-vogue",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 140, max: 170, weight: 1.0),
                JointAngleTarget("rightElbow", min: 40, max: 70, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 30, max: 60, weight: 0.7),
                JointAngleTarget("torsoLean", min: 80, max: 90, weight: 0.8),
                JointAngleTarget("leftKnee", min: 160, max: 180, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "killer-queen-triangle",
            name: "Killer Queen's Hazard Triangle",
            character: "Yoshikage Kira",
            part: 4,
            partName: "Diamond is Unbreakable",
            description: "Kira forms a triangle with his arms overhead, mimicking Killer Queen's deadly silhouette.",
            difficulty: 4,
            category: .menacing,
            rarity: .epic,
            iconicPhrase: "My name is Yoshikage Kira...",
            imageName: "pose_killer-queen-triangle",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 155, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 155, max: 180, weight: 1.0),
                JointAngleTarget("rightElbow", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("leftElbow", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("torsoLean", min: 85, max: 100, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "polnareff-lean",
            name: "Polnareff's Impossible Lean",
            character: "Jean Pierre Polnareff",
            part: 3,
            partName: "Stardust Crusaders",
            description: "Polnareff leans back at an impossible angle with one arm extended, defying gravity with style.",
            difficulty: 4,
            category: .fabulous,
            rarity: .epic,
            iconicPhrase: "Bravo! Oh, bravo!",
            imageName: "pose_polnareff-lean",
            jointTargets: [
                JointAngleTarget("torsoLean", min: 110, max: 135, weight: 1.0),
                JointAngleTarget("rightShoulder", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("rightElbow", min: 150, max: 180, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 20, max: 50, weight: 0.6),
                JointAngleTarget("rightKnee", min: 140, max: 170, weight: 0.7)
            ]
        ),

        PoseCard(
            id: "jolyne-ensemble",
            name: "Jolyne's Stone Ocean Ensemble",
            character: "Jolyne Cujoh",
            part: 6,
            partName: "Stone Ocean",
            description: "Jolyne strikes a confident stance with one hand on her hip and the other threading string between her fingers.",
            difficulty: 3,
            category: .dramatic,
            rarity: .epic,
            iconicPhrase: "Yare yare dawa...",
            imageName: "pose_jolyne-ensemble",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 70, max: 100, weight: 1.0),
                JointAngleTarget("rightElbow", min: 60, max: 90, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 30, max: 55, weight: 0.7),
                JointAngleTarget("leftElbow", min: 70, max: 100, weight: 1.0),
                JointAngleTarget("torsoLean", min: 80, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "lisa-lisa-frame",
            name: "Lisa Lisa's Face Frame",
            character: "Lisa Lisa",
            part: 2,
            partName: "Battle Tendency",
            description: "Lisa Lisa elegantly frames her face with both hands, exuding effortless sophistication.",
            difficulty: 2,
            category: .fabulous,
            rarity: .epic,
            iconicPhrase: "Nice!",
            imageName: "pose_lisa-lisa-frame",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 110, max: 140, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 110, max: 140, weight: 1.0),
                JointAngleTarget("rightElbow", min: 30, max: 55, weight: 1.0),
                JointAngleTarget("leftElbow", min: 30, max: 55, weight: 1.0),
                JointAngleTarget("torsoLean", min: 85, max: 95, weight: 0.5)
            ]
        ),

        // MARK: - Rare

        PoseCard(
            id: "koichi-squat",
            name: "Koichi's Great Days Squat",
            character: "Koichi Hirose",
            part: 4,
            partName: "Diamond is Unbreakable",
            description: "Koichi drops into a wide squat with fists clenched, channeling the Great Days opening energy.",
            difficulty: 3,
            category: .casual,
            rarity: .rare,
            iconicPhrase: "Let's kill da ho!",
            imageName: "pose_koichi-squat",
            jointTargets: [
                JointAngleTarget("rightKnee", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftKnee", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("rightShoulder", min: 40, max: 70, weight: 0.7),
                JointAngleTarget("leftShoulder", min: 40, max: 70, weight: 0.7),
                JointAngleTarget("torsoLean", min: 80, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "caesar-bubble",
            name: "Caesar Zeppeli's Bubble Launcher",
            character: "Caesar Zeppeli",
            part: 2,
            partName: "Battle Tendency",
            description: "Caesar extends both arms forward with palms open, launching his Hamon-infused bubble barrage.",
            difficulty: 3,
            category: .battle,
            rarity: .rare,
            iconicPhrase: "CAESAAAAAAR!",
            imageName: "pose_caesar-bubble",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("rightElbow", min: 140, max: 170, weight: 0.8),
                JointAngleTarget("leftElbow", min: 140, max: 170, weight: 0.8),
                JointAngleTarget("torsoLean", min: 80, max: 90, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "kars-cradle",
            name: "Kars' Self-Cradle",
            character: "Kars",
            part: 2,
            partName: "Battle Tendency",
            description: "Kars wraps his arms around himself in a self-embracing cradle, radiating ultimate superiority.",
            difficulty: 2,
            category: .menacing,
            rarity: .rare,
            iconicPhrase: "I am the ultimate being!",
            imageName: "pose_kars-cradle",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("rightElbow", min: 20, max: 50, weight: 1.0),
                JointAngleTarget("leftElbow", min: 20, max: 50, weight: 1.0),
                JointAngleTarget("torsoLean", min: 85, max: 100, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "rohan-refuse",
            name: "Rohan's \"I Refuse\"",
            character: "Rohan Kishibe",
            part: 4,
            partName: "Diamond is Unbreakable",
            description: "Rohan turns his head sharply to the side with one arm raised in emphatic refusal.",
            difficulty: 3,
            category: .dramatic,
            rarity: .rare,
            iconicPhrase: "I refuse.",
            imageName: "pose_rohan-refuse",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 100, max: 130, weight: 1.0),
                JointAngleTarget("rightElbow", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 10, max: 35, weight: 0.6),
                JointAngleTarget("torsoLean", min: 85, max: 100, weight: 0.7)
            ]
        ),

        PoseCard(
            id: "stroheim-victory",
            name: "Stroheim's Cyborg Victory",
            character: "Rudol von Stroheim",
            part: 2,
            partName: "Battle Tendency",
            description: "Stroheim throws his arms wide open in a bombastic victory pose, chest puffed with pride.",
            difficulty: 3,
            category: .battle,
            rarity: .rare,
            iconicPhrase: "GERMAN SCIENCE IS THE BEST!",
            imageName: "pose_stroheim-victory",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 130, max: 160, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 130, max: 160, weight: 1.0),
                JointAngleTarget("rightElbow", min: 140, max: 170, weight: 0.7),
                JointAngleTarget("leftElbow", min: 140, max: 170, weight: 0.7),
                JointAngleTarget("torsoLean", min: 95, max: 110, weight: 0.8)
            ]
        ),

        PoseCard(
            id: "johnny-gyro-point",
            name: "Johnny & Gyro Lift Point",
            character: "Johnny Joestar & Gyro",
            part: 7,
            partName: "Steel Ball Run",
            description: "Johnny and Gyro point upward together in their iconic dual lift pose from Steel Ball Run.",
            difficulty: 4,
            category: .dramatic,
            rarity: .rare,
            iconicPhrase: "Arigato, Gyro...",
            imageName: "pose_johnny-gyro-point",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 155, max: 180, weight: 1.0),
                JointAngleTarget("rightElbow", min: 155, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 60, max: 90, weight: 0.7),
                JointAngleTarget("leftElbow", min: 80, max: 120, weight: 0.6),
                JointAngleTarget("torsoLean", min: 85, max: 100, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "kakyoin-cover",
            name: "Kakyoin's WSJ Cover",
            character: "Noriaki Kakyoin",
            part: 3,
            partName: "Stardust Crusaders",
            description: "Kakyoin strikes his iconic Weekly Shonen Jump cover pose with crossed arms and a confident tilt.",
            difficulty: 3,
            category: .battle,
            rarity: .rare,
            iconicPhrase: "No one can deflect the Emerald Splash!",
            imageName: "pose_kakyoin-cover",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 60, max: 90, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 60, max: 90, weight: 1.0),
                JointAngleTarget("rightElbow", min: 30, max: 60, weight: 1.0),
                JointAngleTarget("leftElbow", min: 30, max: 60, weight: 1.0),
                JointAngleTarget("torsoLean", min: 80, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "bucciarati-zipper",
            name: "Bucciarati's Zipper Stance",
            character: "Bruno Bucciarati",
            part: 5,
            partName: "Golden Wind",
            description: "Bucciarati stands with one arm extended forward and the other pulled back, ready to unzip reality.",
            difficulty: 3,
            category: .fabulous,
            rarity: .rare,
            iconicPhrase: "Arrivederci!",
            imageName: "pose_bucciarati-zipper",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("rightElbow", min: 145, max: 175, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 20, max: 50, weight: 0.7),
                JointAngleTarget("leftElbow", min: 60, max: 90, weight: 0.7),
                JointAngleTarget("torsoLean", min: 80, max: 92, weight: 0.6)
            ]
        ),

        // MARK: - Common

        PoseCard(
            id: "speedwagon-hat",
            name: "Speedwagon's Hat Tip",
            character: "Robert E.O. Speedwagon",
            part: 1,
            partName: "Phantom Blood",
            description: "Speedwagon tips his hat with one hand while the other rests at his side.",
            difficulty: 1,
            category: .casual,
            rarity: .common,
            iconicPhrase: "Even Speedwagon is afraid!",
            imageName: "pose_speedwagon-hat",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 120, max: 150, weight: 1.0),
                JointAngleTarget("rightElbow", min: 40, max: 70, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 0, max: 20, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "iggy-sit",
            name: "Iggy's Cool Sit",
            character: "Iggy",
            part: 3,
            partName: "Stardust Crusaders",
            description: "Iggy's signature sitting pose adapted for humans: legs crossed, arms relaxed, maximum attitude.",
            difficulty: 1,
            category: .casual,
            rarity: .common,
            iconicPhrase: "*chews gum menacingly*",
            imageName: "pose_iggy-sit",
            jointTargets: [
                JointAngleTarget("rightKnee", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("leftKnee", min: 80, max: 110, weight: 1.0),
                JointAngleTarget("rightShoulder", min: 0, max: 25, weight: 0.6),
                JointAngleTarget("leftShoulder", min: 0, max: 25, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "okuyasu-oi",
            name: "Okuyasu's \"Oi Josuke!\"",
            character: "Okuyasu Nijimura",
            part: 4,
            partName: "Diamond is Unbreakable",
            description: "Okuyasu waves one arm high with an open palm, calling out to his best buddy.",
            difficulty: 1,
            category: .casual,
            rarity: .common,
            iconicPhrase: "Oi, Josuke!",
            imageName: "pose_okuyasu-oi",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("rightElbow", min: 140, max: 175, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 0, max: 25, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "avdol-yes",
            name: "Avdol's \"YES I AM!\"",
            character: "Muhammad Avdol",
            part: 3,
            partName: "Stardust Crusaders",
            description: "Avdol crosses his arms in an X over his chest before throwing them wide open in emphatic affirmation.",
            difficulty: 2,
            category: .battle,
            rarity: .common,
            iconicPhrase: "YES, I AM!",
            imageName: "pose_avdol-yes",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 120, max: 155, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 120, max: 155, weight: 1.0),
                JointAngleTarget("rightElbow", min: 130, max: 165, weight: 0.7),
                JointAngleTarget("leftElbow", min: 130, max: 165, weight: 0.7),
                JointAngleTarget("torsoLean", min: 85, max: 100, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "narancia-dance",
            name: "Narancia's Dance Move",
            character: "Narancia Ghirga",
            part: 5,
            partName: "Golden Wind",
            description: "Narancia grooves with a carefree dance step, one arm swinging and knees slightly bent.",
            difficulty: 2,
            category: .casual,
            rarity: .common,
            iconicPhrase: "VOLARE VIA!",
            imageName: "pose_narancia-dance",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 70, max: 100, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 40, max: 70, weight: 0.7),
                JointAngleTarget("rightKnee", min: 140, max: 165, weight: 1.0),
                JointAngleTarget("leftKnee", min: 120, max: 150, weight: 1.0),
                JointAngleTarget("torsoLean", min: 80, max: 92, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "mista-gun",
            name: "Mista's Gun Pose",
            character: "Guido Mista",
            part: 5,
            partName: "Golden Wind",
            description: "Mista aims his revolver with both hands in a stylish shooting stance, legs planted wide.",
            difficulty: 2,
            category: .battle,
            rarity: .common,
            iconicPhrase: "I hate the number 4!",
            imageName: "pose_mista-gun",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 75, max: 105, weight: 1.0),
                JointAngleTarget("rightElbow", min: 150, max: 180, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 60, max: 90, weight: 0.8),
                JointAngleTarget("leftElbow", min: 110, max: 145, weight: 0.7),
                JointAngleTarget("torsoLean", min: 80, max: 95, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "trish-fashion",
            name: "Trish's Fashion Stance",
            character: "Trish Una",
            part: 5,
            partName: "Golden Wind",
            description: "Trish stands with one hand on her hip and the other tossing her hair back in a fashion-forward pose.",
            difficulty: 2,
            category: .fabulous,
            rarity: .common,
            iconicPhrase: "I am who I am!",
            imageName: "pose_trish-fashion",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 30, max: 55, weight: 0.8),
                JointAngleTarget("rightElbow", min: 60, max: 90, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 120, max: 150, weight: 1.0),
                JointAngleTarget("leftElbow", min: 40, max: 70, weight: 0.8),
                JointAngleTarget("torsoLean", min: 82, max: 95, weight: 0.6)
            ]
        ),

        PoseCard(
            id: "weather-stand",
            name: "Weather Report's Cool Stand",
            character: "Weather Report",
            part: 6,
            partName: "Stone Ocean",
            description: "Weather Report stands silently with arms crossed and head slightly lowered, an aura of quiet menace.",
            difficulty: 1,
            category: .menacing,
            rarity: .common,
            iconicPhrase: "...",
            imageName: "pose_weather-stand",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("leftShoulder", min: 50, max: 80, weight: 1.0),
                JointAngleTarget("rightElbow", min: 25, max: 55, weight: 0.8),
                JointAngleTarget("leftElbow", min: 25, max: 55, weight: 0.8)
            ]
        ),

        PoseCard(
            id: "hermes-fist",
            name: "Hermes' Fist Pump",
            character: "Hermes Costello",
            part: 6,
            partName: "Stone Ocean",
            description: "Hermes pumps her fist into the air with fierce determination.",
            difficulty: 1,
            category: .battle,
            rarity: .common,
            iconicPhrase: "Kiss!",
            imageName: "pose_hermes-fist",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 155, max: 180, weight: 1.0),
                JointAngleTarget("rightElbow", min: 140, max: 170, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 0, max: 20, weight: 0.5)
            ]
        ),

        PoseCard(
            id: "emporio-run",
            name: "Emporio's Scared Run",
            character: "Emporio Alnino",
            part: 6,
            partName: "Stone Ocean",
            description: "Emporio mid-sprint with arms flailing and knees high, running for his life.",
            difficulty: 1,
            category: .casual,
            rarity: .common,
            iconicPhrase: "This is... the power of fate!",
            imageName: "pose_emporio-run",
            jointTargets: [
                JointAngleTarget("rightShoulder", min: 60, max: 90, weight: 0.8),
                JointAngleTarget("leftShoulder", min: 30, max: 60, weight: 0.8),
                JointAngleTarget("rightKnee", min: 70, max: 100, weight: 1.0),
                JointAngleTarget("leftKnee", min: 140, max: 170, weight: 1.0),
                JointAngleTarget("torsoLean", min: 70, max: 85, weight: 0.7)
            ]
        )
    ]

    static func pose(byID id: String) -> PoseCard? {
        allPoses.first { $0.id == id }
    }

    static func poses(forPart part: Int) -> [PoseCard] {
        allPoses.filter { $0.part == part }
    }

    static func poses(forRarity rarity: CardRarity) -> [PoseCard] {
        allPoses.filter { $0.rarity == rarity }
    }
}
