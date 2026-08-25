class Word {
  final String id, french, english, ipa, pronunciation, gender, category, exampleFr, exampleEn;
  const Word({
    required this.id, required this.french, required this.english,
    required this.ipa, required this.pronunciation, required this.gender,
    required this.category, required this.exampleFr, required this.exampleEn,
  });
}

class WordProgress {
  final String wordId, category;
  int learnedOnDay;
  bool mastered;
  DateTime? lastSeen;
  int gotItCount, notYetCount;

  WordProgress({
    required this.wordId, required this.category,
    this.learnedOnDay = -1, this.mastered = false,
    this.lastSeen, this.gotItCount = 0, this.notYetCount = 0,
  });

  bool get isLearned => learnedOnDay >= 0;

  Map<String, dynamic> toJson() => {
    'wordId': wordId, 'category': category,
    'learnedOnDay': learnedOnDay, 'mastered': mastered,
    'lastSeen': lastSeen?.toIso8601String(),
    'gotItCount': gotItCount, 'notYetCount': notYetCount,
  };

  factory WordProgress.fromJson(Map<String, dynamic> j) => WordProgress(
    wordId: j['wordId'], category: j['category'],
    learnedOnDay: j['learnedOnDay'] ?? -1,
    mastered: j['mastered'] ?? false,
    lastSeen: j['lastSeen'] != null ? DateTime.parse(j['lastSeen']) : null,
    gotItCount: j['gotItCount'] ?? 0,
    notYetCount: j['notYetCount'] ?? 0,
  );
}

class Category {
  final String id, name, emoji, group;
  const Category({required this.id, required this.name, required this.emoji, required this.group});
}

const List<Category> categories = [
  Category(id: 'greetings', name: 'Greetings',    emoji: '💬', group: 'Everyday'),
  Category(id: 'food',      name: 'Food & drink',  emoji: '🍽️', group: 'Everyday'),
  Category(id: 'travel',    name: 'Travel',        emoji: '🏙️', group: 'Everyday'),
  Category(id: 'shopping',  name: 'Shopping',      emoji: '🛍️', group: 'Everyday'),
  Category(id: 'emotions',  name: 'Emotions',      emoji: '❤️',  group: 'Advanced'),
  Category(id: 'business',  name: 'Business',      emoji: '💼', group: 'Advanced'),
];
