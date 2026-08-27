class StoryWord {
  final String wordId;     // matches Word.id in word_registry
  final String french;     // the French word as it appears in text
  final String english;    // English meaning
  final String pronunciation;

  const StoryWord({
    required this.wordId,
    required this.french,
    required this.english,
    required this.pronunciation,
  });
}

class StoryPage {
  final String text;             // Full page text in French
  final List<StoryWord> words;   // Words in this page that are tappable

  const StoryPage({required this.text, required this.words});
}

class Story {
  final String id;
  final String title;
  final String titleEn;
  final String category;   // which word category this story draws from
  final String emoji;
  final String teaser;     // one-line description
  final List<StoryPage> pages;

  const Story({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.category,
    required this.emoji,
    required this.teaser,
    required this.pages,
  });
}
