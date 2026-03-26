import Foundation

struct CollectibleCardDatabase {

    static let allCards: [CollectibleCard] = [

        // MARK: - Part 1: Phantom Blood

        CollectibleCard(
            id: "card_jonathan",
            characterName: "Jonathan Joestar",
            standName: nil,
            standAbility: nil,
            characterBio: "El primer JoJo. Un caballero noble y honorable que domina el Hamon para derrotar al vampiro Dio Brando. Su valentía y bondad definen el legado Joestar.",
            part: 1,
            partName: "Phantom Blood",
            rarity: .rare,
            imageName: "pose_jonathan-veil",
            standStats: nil,
            abilityName: "Hamon"
        ),

        CollectibleCard(
            id: "card_dio_p1",
            characterName: "Dio Brando",
            standName: nil,
            standAbility: nil,
            characterBio: "El archienemigo de los Joestar. Nacido en la pobreza, su ambición desmedida lo llevó a rechazar su humanidad y convertirse en un vampiro inmortal.",
            part: 1,
            partName: "Phantom Blood",
            rarity: .epic,
            imageName: "pose_dio-wryyy",
            standStats: nil,
            abilityName: "Vampirismo"
        ),

        CollectibleCard(
            id: "card_speedwagon",
            characterName: "Robert E.O. Speedwagon",
            standName: nil,
            standAbility: nil,
            characterBio: "Un matón de Ogre Street que se convirtió en el aliado más fiel de Jonathan. Su instinto para juzgar el carácter de las personas es infalible.",
            part: 1,
            partName: "Phantom Blood",
            rarity: .common,
            imageName: "pose_speedwagon-hat",
            standStats: nil,
            abilityName: nil
        ),

        // MARK: - Part 2: Battle Tendency

        CollectibleCard(
            id: "card_joseph",
            characterName: "Joseph Joestar",
            standName: nil,
            standAbility: nil,
            characterBio: "Nieto de Jonathan y el JoJo más astuto. Combina Hamon con trucos y predicciones para vencer enemigos aparentemente invencibles. ¡Your next line is...!",
            part: 2,
            partName: "Battle Tendency",
            rarity: .legendary,
            imageName: "pose_joseph-breakdance",
            standStats: nil,
            abilityName: "Hamon"
        ),

        CollectibleCard(
            id: "card_caesar",
            characterName: "Caesar Anthonio Zeppeli",
            standName: nil,
            standAbility: nil,
            characterBio: "Nieto de Will A. Zeppeli y maestro del Hamon de burbujas. Su rivalidad con Joseph se convierte en una profunda amistad sellada con sacrificio.",
            part: 2,
            partName: "Battle Tendency",
            rarity: .rare,
            imageName: "pose_caesar-bubble",
            standStats: nil,
            abilityName: "Hamon (Burbujas)"
        ),

        CollectibleCard(
            id: "card_lisa_lisa",
            characterName: "Lisa Lisa",
            standName: nil,
            standAbility: nil,
            characterBio: "Maestra de Hamon y madre secreta de Joseph. Elegante y letal, entrena a la siguiente generación para enfrentar a los Hombres del Pilar.",
            part: 2,
            partName: "Battle Tendency",
            rarity: .epic,
            imageName: "pose_lisa-lisa-frame",
            standStats: nil,
            abilityName: "Hamon"
        ),

        CollectibleCard(
            id: "card_kars",
            characterName: "Kars",
            standName: nil,
            standAbility: nil,
            characterBio: "Líder de los Hombres del Pilar. Creador de las Máscaras de Piedra, busca la perfección absoluta. Al obtener el Ser Perfecto, domina toda forma de vida.",
            part: 2,
            partName: "Battle Tendency",
            rarity: .legendary,
            imageName: "pose_kars-cradle",
            standStats: nil,
            abilityName: "Modo Supremo"
        ),

        CollectibleCard(
            id: "card_stroheim",
            characterName: "Rudol von Stroheim",
            standName: nil,
            standAbility: nil,
            characterBio: "Oficial alemán convertido en cyborg. Su patriotismo exagerado y su cuerpo mecánico lo convierten en un aliado inesperado contra los Hombres del Pilar.",
            part: 2,
            partName: "Battle Tendency",
            rarity: .rare,
            imageName: "pose_stroheim-victory",
            standStats: nil,
            abilityName: "Cuerpo Cyborg"
        ),

        // MARK: - Part 3: Stardust Crusaders

        CollectibleCard(
            id: "card_jotaro",
            characterName: "Jotaro Kujo",
            standName: "Star Platinum",
            standAbility: "Velocidad y precisión sobrehumanas. Puede detener el tiempo brevemente con Star Platinum: The World.",
            characterBio: "El JoJo más icónico. Un estudiante serio y estoico que viaja a Egipto para salvar a su madre. Su determinación inquebrantable inspira a todos a su alrededor.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .legendary,
            imageName: "pose_jotaro-verdict",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .c,
                durability: .a, precision: .a, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_dio_p3",
            characterName: "DIO",
            standName: "The World",
            standAbility: "Detiene el tiempo por hasta 9 segundos. Un poder absoluto que lo hace prácticamente invencible.",
            characterBio: "Dio Brando renacido. Tras un siglo en el fondo del océano, regresa con un Stand devastador y un ejército de usuarios de Stand a sus órdenes.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .bizarre,
            imageName: "pose_dio-wryyy",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .c,
                durability: .a, precision: .a, developmentPotential: .b
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_kakyoin",
            characterName: "Noriaki Kakyoin",
            standName: "Hierophant Green",
            standAbility: "Stand de largo alcance que dispara Emerald Splash y puede crear barreras de tentáculos.",
            characterBio: "Un estudiante solitario que se une a Jotaro tras ser liberado del control de DIO. Leal hasta el final, su sacrificio es clave para descubrir el poder de The World.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .rare,
            imageName: "pose_kakyoin-cover",
            standStats: StandStats(
                destructivePower: .c, speed: .b, range: .a,
                durability: .b, precision: .c, developmentPotential: .d
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_polnareff",
            characterName: "Jean Pierre Polnareff",
            standName: "Silver Chariot",
            standAbility: "Un Stand espadachín ultra-rápido que puede quitarse su armadura para duplicar su velocidad.",
            characterBio: "Espadachín francés que busca venganza por su hermana. Su personalidad cómica esconde un guerrero feroz y un amigo leal.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .epic,
            imageName: "pose_polnareff-lean",
            standStats: StandStats(
                destructivePower: .c, speed: .a, range: .c,
                durability: .b, precision: .b, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_avdol",
            characterName: "Muhammad Avdol",
            standName: "Magician's Red",
            standAbility: "Control absoluto del fuego. Puede crear llamas con forma de ankh y detectar Stands enemigos.",
            characterBio: "Adivino egipcio y primer aliado de Jotaro. Sabio y valiente, su conocimiento de los Stands guía al grupo en su travesía.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .common,
            imageName: "pose_avdol-yes",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .c,
                durability: .b, precision: .c, developmentPotential: .d
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_iggy",
            characterName: "Iggy",
            standName: "The Fool",
            standAbility: "Manipula arena para crear formas y estructuras. Puede imitar objetos y personas con arena.",
            characterBio: "Un Boston Terrier callejero con actitud. Aunque inicialmente egoísta, demuestra un coraje increíble en la batalla final contra Vanilla Ice.",
            part: 3,
            partName: "Stardust Crusaders",
            rarity: .common,
            imageName: "pose_iggy-sit",
            standStats: StandStats(
                destructivePower: .c, speed: .c, range: .d,
                durability: .c, precision: .d, developmentPotential: .c
            ),
            abilityName: nil
        ),

        // MARK: - Part 4: Diamond is Unbreakable

        CollectibleCard(
            id: "card_josuke",
            characterName: "Josuke Higashikata",
            standName: "Crazy Diamond",
            standAbility: "Puede reparar y restaurar cualquier cosa a su estado original. Un poder de destrucción convertido en curación.",
            characterBio: "Hijo ilegítimo de Joseph Joestar. Un chico amable con un peinado que NO debes insultar. Protege Morioh de las amenazas de usuarios de Stand.",
            part: 4,
            partName: "Diamond is Unbreakable",
            rarity: .legendary,
            imageName: "pose_josuke-vogue",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .d,
                durability: .b, precision: .b, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_koichi",
            characterName: "Koichi Hirose",
            standName: "Echoes",
            standAbility: "Stand que evoluciona en 3 ACTs: sonidos, onomatopeyas físicas, y manipulación de gravedad.",
            characterBio: "Un estudiante pequeño pero valiente. Su Stand evoluciona junto con su crecimiento personal, convirtiéndolo en uno de los usuarios más versátiles.",
            part: 4,
            partName: "Diamond is Unbreakable",
            rarity: .rare,
            imageName: "pose_koichi-squat",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .c,
                durability: .b, precision: .c, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_rohan",
            characterName: "Rohan Kishibe",
            standName: "Heaven's Door",
            standAbility: "Convierte a las personas en libros, puede leer sus memorias y escribir comandos en ellas.",
            characterBio: "Mangaka excéntrico y genio creativo. Obsesionado con la realidad para su manga, su Stand es uno de los más poderosos y versátiles jamás vistos.",
            part: 4,
            partName: "Diamond is Unbreakable",
            rarity: .epic,
            imageName: "pose_rohan-refuse",
            standStats: StandStats(
                destructivePower: .d, speed: .b, range: .b,
                durability: .b, precision: .c, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_okuyasu",
            characterName: "Okuyasu Nijimura",
            standName: "The Hand",
            standAbility: "Borra el espacio con su mano derecha. Todo lo que toca con ella desaparece permanentemente del universo.",
            characterBio: "El mejor amigo de Josuke. Aunque no es el más listo, su lealtad es inquebrantable y su Stand tiene un poder destructivo terrificante.",
            part: 4,
            partName: "Diamond is Unbreakable",
            rarity: .common,
            imageName: "pose_okuyasu-oi",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .d,
                durability: .c, precision: .c, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_kira",
            characterName: "Yoshikage Kira",
            standName: "Killer Queen",
            standAbility: "Convierte cualquier cosa en bomba. Sheer Heart Attack busca calor, y Bites the Dust rebobina el tiempo.",
            characterBio: "Un asesino serial que solo desea una vida tranquila. Su meticulosidad y su Stand devastador lo convierten en el villano más aterrador de Morioh.",
            part: 4,
            partName: "Diamond is Unbreakable",
            rarity: .bizarre,
            imageName: "pose_killer-queen-triangle",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .d,
                durability: .b, precision: .b, developmentPotential: .a
            ),
            abilityName: nil
        ),

        // MARK: - Part 5: Golden Wind

        CollectibleCard(
            id: "card_giorno",
            characterName: "Giorno Giovanna",
            standName: "Gold Experience",
            standAbility: "Otorga vida a objetos inanimados. Evoluciona a Gold Experience Requiem, que anula cualquier acción.",
            characterBio: "Hijo de DIO con el cuerpo de Jonathan. Sueña con convertirse en un Gangstar y reformar la mafia italiana desde dentro. Su determinación es absoluta.",
            part: 5,
            partName: "Golden Wind",
            rarity: .bizarre,
            imageName: "pose_giorno-heart",
            standStats: StandStats(
                destructivePower: .c, speed: .a, range: .c,
                durability: .d, precision: .c, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_bucciarati",
            characterName: "Bruno Bucciarati",
            standName: "Sticky Fingers",
            standAbility: "Crea cremalleras en cualquier superficie para abrir portales, separar objetos o esconderse dentro de otros.",
            characterBio: "Capo de Passione y líder del equipo. Su sentido de justicia lo lleva a traicionar al jefe para proteger a Trish. Un héroe verdadero de corazón puro.",
            part: 5,
            partName: "Golden Wind",
            rarity: .legendary,
            imageName: "pose_bucciarati-zipper",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .c,
                durability: .d, precision: .c, developmentPotential: .d
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_narancia",
            characterName: "Narancia Ghirga",
            standName: "Aerosmith",
            standAbility: "Un avión en miniatura armado con ametralladoras y bombas. Detecta CO2 para rastrear enemigos.",
            characterBio: "El miembro más joven y emotivo del equipo. Su lealtad a Bucciarati es absoluta y su espíritu libre esconde un pasado trágico.",
            part: 5,
            partName: "Golden Wind",
            rarity: .common,
            imageName: "pose_narancia-dance",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .b,
                durability: .c, precision: .e, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_mista",
            characterName: "Guido Mista",
            standName: "Sex Pistols",
            standAbility: "Seis pequeños Stands que redirigen balas con precisión mortal. Cada uno tiene personalidad propia.",
            characterBio: "El pistolero del equipo con tetrafobia extrema. Optimista y leal, su Stand convierte balas simples en proyectiles guiados letales.",
            part: 5,
            partName: "Golden Wind",
            rarity: .common,
            imageName: "pose_mista-gun",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .b,
                durability: .a, precision: .a, developmentPotential: .b
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_trish",
            characterName: "Trish Una",
            standName: "Spice Girl",
            standAbility: "Ablanda cualquier material haciéndolo elástico e indestructible. Un poder defensivo perfecto.",
            characterBio: "Hija del jefe de Passione. Pasa de ser una chica superficial a una guerrera determinada que lucha por su propia supervivencia.",
            part: 5,
            partName: "Golden Wind",
            rarity: .common,
            imageName: "pose_trish-fashion",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .c,
                durability: .a, precision: .d, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_fugo",
            characterName: "Pannacotta Fugo",
            standName: "Purple Haze",
            standAbility: "Libera un virus mortal que disuelve la carne en segundos. Tan peligroso que Fugo apenas puede controlarlo.",
            characterBio: "Genio con problemas de ira. Su Stand refleja su rabia interior. Abandona al equipo por miedo, una decisión que lo persigue para siempre.",
            part: 5,
            partName: "Golden Wind",
            rarity: .epic,
            imageName: "pose_fugo-virus",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .c,
                durability: .e, precision: .e, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_abbacchio",
            characterName: "Leone Abbacchio",
            standName: "Moody Blues",
            standAbility: "Reproduce eventos pasados como una grabación. Puede transformarse en cualquier persona del pasado.",
            characterBio: "Ex-policía corrupto atormentado por la culpa. Encuentra redención sirviendo a Bucciarati, usando su Stand de investigación para rastrear al jefe.",
            part: 5,
            partName: "Golden Wind",
            rarity: .rare,
            imageName: "pose_abbacchio-replay",
            standStats: StandStats(
                destructivePower: .c, speed: .c, range: .a,
                durability: .c, precision: .c, developmentPotential: .c
            ),
            abilityName: nil
        ),

        // MARK: - Part 6: Stone Ocean

        CollectibleCard(
            id: "card_jolyne",
            characterName: "Jolyne Cujoh",
            standName: "Stone Free",
            standAbility: "Convierte su cuerpo en hilos que puede usar para atar, crear redes, coser heridas y escuchar a distancia.",
            characterBio: "Hija de Jotaro. Encarcelada injustamente, despierta su Stand en prisión y lucha contra la conspiración de Pucci para proteger a su padre.",
            part: 6,
            partName: "Stone Ocean",
            rarity: .legendary,
            imageName: "pose_jolyne-ensemble",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .c,
                durability: .a, precision: .c, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_hermes",
            characterName: "Hermes Costello",
            standName: "Kiss",
            standAbility: "Pega stickers que duplican objetos. Al removerlos, los duplicados se fusionan violentamente con el original.",
            characterBio: "Compañera de celda de Jolyne. Dura y directa, busca venganza por el asesinato de su hermana mientras se convierte en la mejor aliada de Jolyne.",
            part: 6,
            partName: "Stone Ocean",
            rarity: .common,
            imageName: "pose_hermes-fist",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .c,
                durability: .a, precision: .c, developmentPotential: .b
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_weather",
            characterName: "Weather Report",
            standName: "Weather Report",
            standAbility: "Control total del clima. Puede crear tormentas, lluvia de ranas venenosas y manipular la atmósfera.",
            characterBio: "Prisionero amnésico con un pasado trágico. Su Stand controla el clima con un poder devastador que oculta una habilidad aún más aterradora.",
            part: 6,
            partName: "Stone Ocean",
            rarity: .epic,
            imageName: "pose_weather-stand",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .a,
                durability: .a, precision: .e, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_emporio",
            characterName: "Emporio Alnino",
            standName: "Burning Down the House",
            standAbility: "Accede a una habitación fantasma dentro de la prisión que solo él puede encontrar y usar.",
            characterBio: "Un niño nacido en prisión. Parece indefenso pero su coraje e inteligencia resultan cruciales en la batalla final contra Pucci.",
            part: 6,
            partName: "Stone Ocean",
            rarity: .common,
            imageName: "pose_emporio-run",
            standStats: StandStats(
                destructivePower: .none, speed: .none, range: .none,
                durability: .a, precision: .none, developmentPotential: .none
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_pucci",
            characterName: "Enrico Pucci",
            standName: "Whitesnake",
            standAbility: "Extrae memorias y Stands en forma de discos. Evoluciona a C-Moon y luego a Made in Heaven.",
            characterBio: "Sacerdote devoto y discípulo de DIO. Su plan para alcanzar el 'cielo' y resetear el universo amenaza la existencia de todos los Joestar.",
            part: 6,
            partName: "Stone Ocean",
            rarity: .bizarre,
            imageName: "pose_pucci-heaven",
            standStats: StandStats(
                destructivePower: .none, speed: .d, range: .none,
                durability: .none, precision: .none, developmentPotential: .a
            ),
            abilityName: nil
        ),

        // MARK: - Part 7: Steel Ball Run

        CollectibleCard(
            id: "card_johnny",
            characterName: "Johnny Joestar",
            standName: "Tusk",
            standAbility: "Dispara las uñas como balas giratorias. Evoluciona en 4 ACTs hasta alcanzar la rotación infinita.",
            characterBio: "Ex-jockey paralítico del universo alterno. La Steel Ball Run le devuelve la esperanza. Su evolución de cobarde a héroe es la más profunda de la saga.",
            part: 7,
            partName: "Steel Ball Run",
            rarity: .legendary,
            imageName: "pose_johnny-gyro-point",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .b,
                durability: .c, precision: .a, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_gyro",
            characterName: "Gyro Zeppeli",
            standName: "Ball Breaker",
            standAbility: "Usa la rotación infinita a través de sus bolas de acero. Ball Breaker entra en la dimensión del enemigo.",
            characterBio: "Ejecutor napolitano que participa en la carrera para salvar a un niño inocente. Mentor de Johnny y heredero de la técnica Zeppeli.",
            part: 7,
            partName: "Steel Ball Run",
            rarity: .epic,
            imageName: "pose_gyro-steel",
            standStats: StandStats(
                destructivePower: .a, speed: .b, range: .c,
                durability: .c, precision: .c, developmentPotential: .c
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_valentine",
            characterName: "Funny Valentine",
            standName: "D4C - Love Train",
            standAbility: "Viaja entre dimensiones paralelas. Love Train redirige toda desgracia lejos de Valentine.",
            characterBio: "Presidente de los Estados Unidos con patriotismo extremo. Su Stand dimensional lo hace prácticamente inmortal. El villano más complejo de JoJo.",
            part: 7,
            partName: "Steel Ball Run",
            rarity: .bizarre,
            imageName: "pose_valentine-flag",
            standStats: StandStats(
                destructivePower: .a, speed: .a, range: .c,
                durability: .a, precision: .a, developmentPotential: .a
            ),
            abilityName: nil
        ),

        CollectibleCard(
            id: "card_diego",
            characterName: "Diego Brando",
            standName: "Scary Monsters",
            standAbility: "Se transforma en dinosaurio y puede convertir a otros en dinosaurios bajo su control.",
            characterBio: "Versión del universo alterno de Dio. Jockey brillante y despiadado, su rivalidad con Johnny es personal y letal.",
            part: 7,
            partName: "Steel Ball Run",
            rarity: .epic,
            imageName: "pose_diego-dino",
            standStats: StandStats(
                destructivePower: .b, speed: .b, range: .c,
                durability: .b, precision: .c, developmentPotential: .c
            ),
            abilityName: nil
        )
    ]

    static func card(byID id: String) -> CollectibleCard? {
        allCards.first { $0.id == id }
    }

    static func cards(forPart part: Int) -> [CollectibleCard] {
        allCards.filter { $0.part == part }
    }

    static func cards(forRarity rarity: CardRarity) -> [CollectibleCard] {
        allCards.filter { $0.rarity == rarity }
    }
}
