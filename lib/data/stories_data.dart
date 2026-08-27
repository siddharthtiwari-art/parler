import '../models/story.dart';

const List<Story> allStories = [

  // ── 1. GREETINGS ──────────────────────────────────────────────────────────
  Story(
    id: 'story_greetings',
    title: 'Une Nouvelle Amie',
    titleEn: 'A New Friend',
    category: 'greetings',
    emoji: '💬',
    teaser: 'Sophie meets a stranger at a Parisian café.',
    pages: [
      StoryPage(
        text: 'Sophie entre dans un café à Paris. Elle voit un homme assis seul près de la fenêtre. Elle s\'approche et dit : « Bonjour ! Je m\'appelle Sophie. Êtes-vous nouveau dans cette ville ? » L\'homme sourit et répond : « Oui, je suis arrivé hier. Enchanté, je m\'appelle Marco. » Sophie est ravie de rencontrer quelqu\'un de nouveau. Ils commencent à parler et Sophie lui demande : « Ça va ? Vous semblez un peu fatigué. » Marco répond : « Oui, un peu, mais très bien merci. »',
        words: [
          StoryWord(wordId: 'g01', french: 'Bonjour', english: 'Hello / Good morning', pronunciation: 'bohn-ZHOOR'),
          StoryWord(wordId: 'g17', french: 'Je m\'appelle', english: 'My name is', pronunciation: 'zhuh mah-PEL'),
          StoryWord(wordId: 'g16', french: 'Enchanté', english: 'Nice to meet you', pronunciation: 'ahn-shahn-TAY'),
          StoryWord(wordId: 'g31', french: 'ravie', english: 'delighted', pronunciation: 'rah-VEE'),
          StoryWord(wordId: 'g14', french: 'Ça va', english: 'How\'s it going', pronunciation: 'sah VAH'),
        ],
      ),
      StoryPage(
        text: 'Marco commande deux cafés et ils continuent leur conversation. « S\'il vous plaît, » dit-il au serveur, « deux cafés au lait. » Sophie lui explique les meilleurs endroits à visiter à Paris. « Bien sûr, vous devez voir la Tour Eiffel ! » dit-elle. Marco rit et répond : « D\'accord, j\'irai demain matin. » À la fin de l\'après-midi, ils se lèvent pour partir. « Au revoir, Marco ! À bientôt ! » dit Sophie. Marco répond avec un grand sourire : « À bientôt, Sophie ! Merci pour tout. »',
        words: [
          StoryWord(wordId: 'g09', french: 'S\'il vous plaît', english: 'Please (formal)', pronunciation: 'seel voo PLAY'),
          StoryWord(wordId: 'g21', french: 'Bien sûr', english: 'Of course', pronunciation: 'byaN SOOR'),
          StoryWord(wordId: 'g22', french: 'D\'accord', english: 'OK / Agreed', pronunciation: 'dah-KOR'),
          StoryWord(wordId: 'g04', french: 'Au revoir', english: 'Goodbye', pronunciation: 'oh ruh-VWAHR'),
          StoryWord(wordId: 'g24', french: 'À bientôt', english: 'See you soon', pronunciation: 'ah byaN-TOH'),
          StoryWord(wordId: 'g07', french: 'Merci', english: 'Thank you', pronunciation: 'mair-SEE'),
        ],
      ),
      StoryPage(
        text: 'Le lendemain, Marco envoie un message à Sophie : « Bonjour ! Je suis à la Tour Eiffel. C\'est magnifique ! » Sophie répond rapidement : « Bonne journée, Marco ! Quoi de neuf ? » Il écrit : « Pas grand-chose, juste de belles photos ! » Sophie sourit en lisant le message. Elle est heureuse d\'avoir un nouvel ami à Paris. Elle répond : « Volontiers, retrouvons-nous demain pour le déjeuner ! » Marco répond immédiatement : « Avec plaisir ! À demain, Sophie ! »',
        words: [
          StoryWord(wordId: 'g26', french: 'Bonne journée', english: 'Have a good day', pronunciation: 'bun zhoor-NAY'),
          StoryWord(wordId: 'g29', french: 'Quoi de neuf', english: 'What\'s new', pronunciation: 'kwah duh NUHF'),
          StoryWord(wordId: 'g30', french: 'Pas grand-chose', english: 'Not much', pronunciation: 'pah graN SHOHZ'),
          StoryWord(wordId: 'g49', french: 'Volontiers', english: 'Gladly / Willingly', pronunciation: 'voh-loN-TYAY'),
          StoryWord(wordId: 'g27', french: 'Avec plaisir', english: 'With pleasure', pronunciation: 'ah-vek pleh-ZEER'),
          StoryWord(wordId: 'g25', french: 'À demain', english: 'See you tomorrow', pronunciation: 'ah duh-MaN'),
        ],
      ),
    ],
  ),

  // ── 2. FOOD ───────────────────────────────────────────────────────────────
  Story(
    id: 'story_food',
    title: 'Le Dîner Parfait',
    titleEn: 'The Perfect Dinner',
    category: 'food',
    emoji: '🍽️',
    teaser: 'Luc tries to cook a French dinner for his family.',
    pages: [
      StoryPage(
        text: 'Luc veut préparer un dîner parfait pour sa famille. Il va au marché pour acheter des ingrédients frais. Il prend du pain, du fromage, et de la viande. Le vendeur lui dit : « Ce poulet est très savoureux, monsieur ! » Luc répond : « Parfait, je le prends ! » Il achète aussi des légumes et des fruits pour la salade. Sa femme lui avait donné la recette de sa grand-mère. Luc est excité de la cuisiner pour la première fois.',
        words: [
          StoryWord(wordId: 'f01', french: 'pain', english: 'bread', pronunciation: 'PaN'),
          StoryWord(wordId: 'f02', french: 'fromage', english: 'cheese', pronunciation: 'froh-MAHZH'),
          StoryWord(wordId: 'f10', french: 'viande', english: 'meat', pronunciation: 'vyaNd'),
          StoryWord(wordId: 'f11', french: 'poulet', english: 'chicken', pronunciation: 'poo-LAY'),
          StoryWord(wordId: 'f32', french: 'savoureux', english: 'tasty', pronunciation: 'sah-voo-RUH'),
          StoryWord(wordId: 'f13', french: 'légumes', english: 'vegetables', pronunciation: 'lay-GYOOM'),
          StoryWord(wordId: 'f44', french: 'recette', english: 'recipe', pronunciation: 'ruh-SET'),
        ],
      ),
      StoryPage(
        text: 'De retour à la maison, Luc commence à cuisiner. Il fait cuire le poulet avec des oignons et des tomates. L\'odeur dans la cuisine est délicieuse. Sa fille entre et demande : « Papa, qu\'est-ce que tu prépares ? » Luc sourit : « Le dîner ! Tu veux goûter la sauce ? » Elle dit : « Oui ! Oh, c\'est chaud mais délicieux ! » Luc ajoute du sel et un peu de sucre pour équilibrer les saveurs. Il prépare aussi une salade fraîche avec du beurre et du citron.',
        words: [
          StoryWord(wordId: 'f18', french: 'oignons', english: 'onions', pronunciation: 'oh-NYON'),
          StoryWord(wordId: 'f17', french: 'tomates', english: 'tomatoes', pronunciation: 'toh-MAT'),
          StoryWord(wordId: 'f31', french: 'délicieuse', english: 'delicious', pronunciation: 'day-lee-SYUH'),
          StoryWord(wordId: 'f48', french: 'goûter', english: 'to taste', pronunciation: 'goo-TAY'),
          StoryWord(wordId: 'f33', french: 'chaud', english: 'hot', pronunciation: 'SHOH'),
          StoryWord(wordId: 'f19', french: 'sel', english: 'salt', pronunciation: 'SEL'),
          StoryWord(wordId: 'f20', french: 'sucre', english: 'sugar', pronunciation: 'SOO-kruh'),
          StoryWord(wordId: 'f38', french: 'fraîche', english: 'fresh', pronunciation: 'FRESH'),
        ],
      ),
      StoryPage(
        text: 'À vingt heures, toute la famille est réunie autour de la table. Luc apporte le plat principal et dit fièrement : « Bon appétit à tous ! » La famille goûte le repas. Sa mère dit : « C\'est absolument délicieux, Luc ! Meilleur que le restaurant. » Sa femme ajoute : « Tu dois me donner la recette. » Après le dîner, Luc sert le dessert — un gâteau au chocolat avec de la crème. Sa fille s\'écrie : « C\'est le meilleur dîner de ma vie ! »',
        words: [
          StoryWord(wordId: 'f39', french: 'plat', english: 'dish', pronunciation: 'PLAH'),
          StoryWord(wordId: 'f35', french: 'Bon appétit', english: 'Enjoy your meal', pronunciation: 'bohn ah-pay-TEE'),
          StoryWord(wordId: 'f40', french: 'repas', english: 'meal', pronunciation: 'ruh-PAH'),
          StoryWord(wordId: 'f28', french: 'restaurant', english: 'restaurant', pronunciation: 'res-toh-RAHN'),
          StoryWord(wordId: 'f23', french: 'dessert', english: 'dessert', pronunciation: 'deh-ZAIR'),
          StoryWord(wordId: 'f24', french: 'gâteau', english: 'cake', pronunciation: 'gah-TOH'),
          StoryWord(wordId: 'f25', french: 'crème', english: 'cream', pronunciation: 'KREM'),
        ],
      ),
    ],
  ),

  // ── 3. TRAVEL ─────────────────────────────────────────────────────────────
  Story(
    id: 'story_travel',
    title: 'Perdu à Lyon',
    titleEn: 'Lost in Lyon',
    category: 'travel',
    emoji: '🏙️',
    teaser: 'Emma loses her way in Lyon and discovers something wonderful.',
    pages: [
      StoryPage(
        text: 'Emma arrive à la gare de Lyon avec sa valise. Elle a une réservation dans un hôtel près du centre-ville. Elle sort de la gare et cherche un taxi. Un chauffeur s\'arrête et demande : « Où allez-vous, madame ? » Emma répond : « À l\'hôtel Lumière, s\'il vous plaît. » Le taxi traverse la ville. Emma regarde par la fenêtre avec émerveillement. La ville est magnifique. Mais soudain, le taxi s\'arrête dans un quartier qu\'Emma ne reconnaît pas.',
        words: [
          StoryWord(wordId: 't02', french: 'gare', english: 'train station', pronunciation: 'GAR'),
          StoryWord(wordId: 't05', french: 'valise', english: 'suitcase', pronunciation: 'vah-LEEZ'),
          StoryWord(wordId: 't08', french: 'réservation', english: 'reservation', pronunciation: 'ray-zair-vah-SYON'),
          StoryWord(wordId: 't06', french: 'hôtel', english: 'hotel', pronunciation: 'loh-TEL'),
          StoryWord(wordId: 't09', french: 'taxi', english: 'taxi', pronunciation: 'tak-SEE'),
          StoryWord(wordId: 't22', french: 'quartier', english: 'neighbourhood', pronunciation: 'kar-TYAY'),
        ],
      ),
      StoryPage(
        text: 'Le chauffeur dit : « Désolé, je me suis trompé de rue. » Emma paie et descend avec sa valise. Elle est perdue. Elle cherche la carte sur son téléphone mais la batterie est morte. Elle voit un passant et demande : « Excusez-moi, où est l\'hôtel Lumière ? » L\'homme réfléchit et dit : « Continuez tout droit, puis tournez à gauche au feu. C\'est près du musée, à droite. » Emma le remercie et suit les indications. Elle passe devant de jolies boutiques et un marché animé.',
        words: [
          StoryWord(wordId: 't15', french: 'rue', english: 'street', pronunciation: 'ROO'),
          StoryWord(wordId: 't16', french: 'carte', english: 'map', pronunciation: 'KART'),
          StoryWord(wordId: 't17', french: 'tout droit', english: 'straight ahead', pronunciation: 'too DRWAH'),
          StoryWord(wordId: 't18', french: 'à gauche', english: 'to the left', pronunciation: 'ah GOHSH'),
          StoryWord(wordId: 't23', french: 'musée', english: 'museum', pronunciation: 'moo-ZAY'),
          StoryWord(wordId: 't19', french: 'à droite', english: 'to the right', pronunciation: 'ah DRWAHT'),
        ],
      ),
      StoryPage(
        text: 'Emma trouve enfin son hôtel. La réceptionniste l\'accueille chaleureusement : « Bienvenue, madame ! Votre chambre est prête. » Emma monte dans sa chambre et pose sa valise. Elle est fatiguée après ce voyage inattendu mais heureuse. Le lendemain, elle décide de visiter le musée qu\'elle a vu. Elle prend le métro et achète un billet. La ville de Lyon lui réserve encore de belles surprises. Elle réalise que se perdre peut parfois mener aux meilleures découvertes.',
        words: [
          StoryWord(wordId: 't07', french: 'chambre', english: 'room', pronunciation: 'SHAHM-bruh'),
          StoryWord(wordId: 't27', french: 'voyage', english: 'journey', pronunciation: 'vwah-YAZH'),
          StoryWord(wordId: 't34', french: 'visiter', english: 'to visit', pronunciation: 'vee-zee-TAY'),
          StoryWord(wordId: 't10', french: 'métro', english: 'metro', pronunciation: 'may-TROH'),
          StoryWord(wordId: 't03', french: 'billet', english: 'ticket', pronunciation: 'bee-YEH'),
        ],
      ),
    ],
  ),

  // ── 4. SHOPPING ───────────────────────────────────────────────────────────
  Story(
    id: 'story_shopping',
    title: 'Les Soldes de janvier',
    titleEn: 'The January Sales',
    category: 'shopping',
    emoji: '🛍️',
    teaser: 'Claire hunts for bargains during the Paris sales.',
    pages: [
      StoryPage(
        text: 'Claire adore les soldes. Chaque janvier, elle visite ses magasins préférés à Paris. Ce matin, elle entre dans une boutique de vêtements. Les réductions sont incroyables — jusqu\'à cinquante pourcent. Elle trouve une robe rouge magnifique en vitrine. Elle demande à la vendeuse : « Quelle est la taille disponible ? » La vendeuse répond : « Nous avons du trente-six au quarante-deux. Voulez-vous l\'essayer ? » Claire accepte et se dirige vers la cabine d\'essayage.',
        words: [
          StoryWord(wordId: 's08', french: 'soldes', english: 'sales', pronunciation: 'SOLD'),
          StoryWord(wordId: 's01', french: 'magasins', english: 'shops', pronunciation: 'mah-gah-ZaN'),
          StoryWord(wordId: 's07', french: 'réductions', english: 'discounts', pronunciation: 'ray-dook-SYON'),
          StoryWord(wordId: 's22', french: 'robe', english: 'dress', pronunciation: 'ROB'),
          StoryWord(wordId: 's30', french: 'vitrine', english: 'shop window', pronunciation: 'vee-TREEN'),
          StoryWord(wordId: 's09', french: 'taille', english: 'size', pronunciation: 'TIE'),
          StoryWord(wordId: 's11', french: 'essayer', english: 'to try on', pronunciation: 'es-ay-YAY'),
          StoryWord(wordId: 's12', french: 'cabine d\'essayage', english: 'fitting room', pronunciation: 'kah-BEEN des-ay-YAZH'),
        ],
      ),
      StoryPage(
        text: 'La robe lui va à merveille. Claire décide de l\'acheter. Elle regarde l\'étiquette — le prix est de quatre-vingts euros, réduit de cent cinquante. C\'est vraiment bon marché pour cette qualité. Elle prend aussi un manteau bleu et une chemise blanche. À la caisse, elle demande : « Acceptez-vous la carte bancaire ? » La vendeuse dit : « Oui, bien sûr. » Claire paie et reçoit son reçu. « Gardez-le, » dit la vendeuse, « en cas de retour. »',
        words: [
          StoryWord(wordId: 's03', french: 'prix', english: 'price', pronunciation: 'PREE'),
          StoryWord(wordId: 's06', french: 'bon marché', english: 'cheap / good value', pronunciation: 'bohn mar-SHAY'),
          StoryWord(wordId: 's24', french: 'qualité', english: 'quality', pronunciation: 'kah-lee-TAY'),
          StoryWord(wordId: 's20', french: 'manteau', english: 'coat', pronunciation: 'maN-TOH'),
          StoryWord(wordId: 's36', french: 'caisse', english: 'till / checkout', pronunciation: 'KES'),
          StoryWord(wordId: 's15', french: 'carte bancaire', english: 'bank card', pronunciation: 'kart baN-KAIR'),
          StoryWord(wordId: 's13', french: 'reçu', english: 'receipt', pronunciation: 'ruh-SOO'),
        ],
      ),
      StoryPage(
        text: 'L\'après-midi, Claire visite le marché en plein air. Les vendeurs proposent des produits frais et des articles d\'occasion à très bon prix. Elle trouve un sac en cuir vintage — la marque est célèbre mais le prix est très doux. Elle négocie avec le vendeur : « C\'est trop cher. Vous pouvez faire une réduction ? » Il sourit : « Pour vous, je fais vingt pourcent de moins. » Claire est ravie. Elle rentre chez elle, les bras chargés de sacs, épuisée mais heureuse de ses bonnes affaires.',
        words: [
          StoryWord(wordId: 's02', french: 'marché', english: 'market', pronunciation: 'mar-SHAY'),
          StoryWord(wordId: 's23', french: 'd\'occasion', english: 'second-hand', pronunciation: 'doh-kah-ZYON'),
          StoryWord(wordId: 's25', french: 'marque', english: 'brand', pronunciation: 'MARK'),
          StoryWord(wordId: 's05', french: 'cher', english: 'expensive', pronunciation: 'SHAIR'),
          StoryWord(wordId: 's07', french: 'réduction', english: 'discount', pronunciation: 'ray-dook-SYON'),
        ],
      ),
    ],
  ),

  // ── 5. EMOTIONS ───────────────────────────────────────────────────────────
  Story(
    id: 'story_emotions',
    title: 'Le Jour de la Décision',
    titleEn: 'The Day of the Decision',
    category: 'emotions',
    emoji: '❤️',
    teaser: 'Thomas faces a life-changing decision and all the feelings that come with it.',
    pages: [
      StoryPage(
        text: 'Thomas est debout devant la fenêtre de son bureau. Il tient une lettre dans ses mains. C\'est une offre d\'emploi à Tokyo — le poste de ses rêves. Mais cela signifie quitter sa famille, ses amis, sa vie parisienne. Il se sent partagé entre l\'excitation et la peur. Son cœur bat vite. Il est à la fois excité par cette opportunité et effrayé par l\'inconnu. Sa collègue Amina entre et le voit pensif : « Thomas, ça va ? Tu sembles inquiet. »',
        words: [
          StoryWord(wordId: 'e18', french: 'excitation', english: 'excitement', pronunciation: 'ex-see-tah-SYON'),
          StoryWord(wordId: 'e23', french: 'peur', english: 'fear', pronunciation: 'PUHR'),
          StoryWord(wordId: 'e05', french: 'effrayé', english: 'frightened', pronunciation: 'ef-reh-YAY'),
          StoryWord(wordId: 'e09', french: 'inquiet', english: 'worried', pronunciation: 'aN-KYEH'),
        ],
      ),
      StoryPage(
        text: 'Thomas explique la situation à Amina. Elle l\'écoute attentivement et dit : « Je comprends que tu sois partagé. C\'est normal de ressentir tout ça. » Thomas soupire : « Je suis reconnaissant pour cette opportunité, mais je me sens coupable de laisser ma famille. » Amina répond : « Il faut espérer et être confiant. Ta famille sera fière de toi. » Ces mots touchent profondément Thomas. Il réalise qu\'il a peur de l\'échec, mais qu\'il serait encore plus triste de ne jamais essayer.',
        words: [
          StoryWord(wordId: 'e29', french: 'ressentir', english: 'to feel', pronunciation: 'ruh-saN-TEER'),
          StoryWord(wordId: 'e14', french: 'reconnaissant', english: 'grateful', pronunciation: 'ruh-koh-neh-SAHN'),
          StoryWord(wordId: 'e34', french: 'espérer', english: 'to hope', pronunciation: 'es-pay-RAY'),
          StoryWord(wordId: 'e15', french: 'confiant', english: 'confident', pronunciation: 'koN-fyaN'),
          StoryWord(wordId: 'e07', french: 'fière', english: 'proud', pronunciation: 'FYAIR'),
          StoryWord(wordId: 'e49', french: 'touchent', english: 'move (emotionally)', pronunciation: 'too-SHAY'),
          StoryWord(wordId: 'e02', french: 'triste', english: 'sad', pronunciation: 'TREEST'),
        ],
      ),
      StoryPage(
        text: 'Le soir, Thomas appelle sa mère. Il lui parle de l\'offre. Elle reste silencieuse un moment, puis dit doucement : « Mon fils, tu dois suivre ton cœur. Nous serons toujours là pour toi. » Thomas ressent une vague de joie et de soulagement. Il comprend que l\'amour de sa famille ne dépend pas de la distance. Le lendemain matin, Thomas envoie sa réponse : il accepte le poste. Il se sent soulagé, optimiste et passionné pour cette nouvelle aventure. Parfois, le courage, c\'est simplement faire le premier pas.',
        words: [
          StoryWord(wordId: 'e21', french: 'joie', english: 'joy', pronunciation: 'ZHWAH'),
          StoryWord(wordId: 'e08', french: 'soulagé', english: 'relieved', pronunciation: 'soo-lah-ZHAY'),
          StoryWord(wordId: 'e25', french: 'amour', english: 'love', pronunciation: 'lah-MOOR'),
          StoryWord(wordId: 'e37', french: 'optimiste', english: 'optimistic', pronunciation: 'op-tee-MEEST'),
          StoryWord(wordId: 'e43', french: 'passionné', english: 'passionate', pronunciation: 'pah-syo-NAY'),
          StoryWord(wordId: 'e27', french: 'courage', english: 'courage', pronunciation: 'koo-RAZH'),
        ],
      ),
    ],
  ),

  // ── 6. BUSINESS ───────────────────────────────────────────────────────────
  Story(
    id: 'story_business',
    title: 'La Grande Réunion',
    titleEn: 'The Big Meeting',
    category: 'business',
    emoji: '💼',
    teaser: 'Léa must save a major contract in a high-stakes meeting.',
    pages: [
      StoryPage(
        text: 'Léa est directrice d\'une entreprise de technologie à Paris. Ce matin, elle a une réunion cruciale avec un grand client allemand. Le contrat représente deux millions d\'euros pour l\'entreprise. Elle prépare son rapport et vérifie chaque chiffre du budget. Son équipe est inquiète — si ce contrat échoue, plusieurs employés pourraient perdre leur poste. Léa reste calme et dit à son équipe : « Nous avons travaillé dur pour ce projet. Faisons-le ensemble. »',
        words: [
          StoryWord(wordId: 'b10', french: 'entreprise', english: 'company', pronunciation: 'laN-truh-PREEZ'),
          StoryWord(wordId: 'b01', french: 'réunion', english: 'meeting', pronunciation: 'ray-oo-NYON'),
          StoryWord(wordId: 'b04', french: 'client', english: 'client', pronunciation: 'klee-AHN'),
          StoryWord(wordId: 'b03', french: 'contrat', english: 'contract', pronunciation: 'koN-TRAH'),
          StoryWord(wordId: 'b35', french: 'rapport', english: 'report', pronunciation: 'rah-POR'),
          StoryWord(wordId: 'b06', french: 'budget', english: 'budget', pronunciation: 'boo-ZHEH'),
          StoryWord(wordId: 'b11', french: 'employés', english: 'employees', pronunciation: 'laN-plwah-YAY'),
        ],
      ),
      StoryPage(
        text: 'La réunion commence. Léa présente la stratégie de l\'entreprise avec confiance. Elle explique comment leur solution peut augmenter la productivité du client de trente pourcent. Le directeur allemand pose des questions difficiles sur les délais et les coûts. Léa répond clairement et propose de négocier les termes du contrat. « Nous pouvons réduire notre marge pour vous offrir un meilleur prix, » dit-elle. Le client est impressionné par sa transparence. Les discussions durent deux heures.',
        words: [
          StoryWord(wordId: 'b21', french: 'présente', english: 'presents', pronunciation: 'pray-zaN-TAY'),
          StoryWord(wordId: 'b17', french: 'stratégie', english: 'strategy', pronunciation: 'strah-tay-ZHEE'),
          StoryWord(wordId: 'b44', french: 'productivité', english: 'productivity', pronunciation: 'pro-dook-tee-vee-TAY'),
          StoryWord(wordId: 'b18', french: 'délais', english: 'deadlines', pronunciation: 'day-LAY'),
          StoryWord(wordId: 'b19', french: 'négocier', english: 'to negotiate', pronunciation: 'nay-goh-SYAY'),
          StoryWord(wordId: 'b26', french: 'réduire', english: 'to reduce', pronunciation: 'ray-DWEER'),
        ],
      ),
      StoryPage(
        text: 'À la fin de la réunion, le directeur allemand tend la main à Léa : « Madame Léa, nous avons un accord. » L\'équipe de Léa retient son souffle, puis éclate de joie. Léa signe le contrat avec un sourire. Le soir, elle rassemble son équipe pour célébrer. « Ce succès, c\'est le vôtre, » dit-elle. « Chaque employé a contribué à cette réussite. » Les bénéfices de ce contrat permettront à l\'entreprise de se développer et d\'embaucher de nouveaux talents. C\'est une belle victoire pour toute l\'équipe.',
        words: [
          StoryWord(wordId: 'b38', french: 'accord', english: 'agreement', pronunciation: 'lah-KOR'),
          StoryWord(wordId: 'b39', french: 'réussite', english: 'success', pronunciation: 'ray-oo-SEET'),
          StoryWord(wordId: 'b07', french: 'bénéfices', english: 'profits', pronunciation: 'bay-nay-FEES'),
          StoryWord(wordId: 'b27', french: 'développer', english: 'to develop', pronunciation: 'day-vloh-PAY'),
          StoryWord(wordId: 'b24', french: 'embaucher', english: 'to hire', pronunciation: 'aN-boh-SHAY'),
        ],
      ),
    ],
  ),
];
