import '../models/word.dart';
import 'words_greetings_food.dart';
import 'words_travel_shopping.dart';
import 'words_emotions_business.dart';

final List<Word> allWords = [
  ...greetingWords,
  ...foodWords,
  ...travelWords,
  ...shoppingWords,
  ...emotionWords,
  ...businessWords,
];

List<Word> wordsForCategory(String categoryId) =>
    allWords.where((w) => w.category == categoryId).toList();

Word? wordById(String id) {
  try { return allWords.firstWhere((w) => w.id == id); }
  catch (_) { return null; }
}
