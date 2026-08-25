import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word.dart';
import '../data/word_registry.dart';

class ProgressService extends ChangeNotifier {
  Map<String, WordProgress> _progress = {};
  int _currentDay = 0;
  DateTime? _lastOpenDate;
  Map<String, int> _streaks = {};

  Map<String, WordProgress> get progress => _progress;
  int get currentDay => _currentDay;
  Map<String, int> get streaks => _streaks;
  int get totalStreak => _streaks.values.fold(0, (a, b) => a > b ? a : b);

  ProgressService() { _load(); }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _currentDay = prefs.getInt('current_day') ?? 0;
    final lastStr = prefs.getString('last_open_date');
    _lastOpenDate = lastStr != null ? DateTime.parse(lastStr) : null;
    final today = DateTime.now();
    if (_lastOpenDate != null) {
      final diff = DateTime(today.year, today.month, today.day)
          .difference(DateTime(_lastOpenDate!.year, _lastOpenDate!.month, _lastOpenDate!.day))
          .inDays;
      if (diff > 0) _currentDay += diff;
    }
    await prefs.setInt('current_day', _currentDay);
    await prefs.setString('last_open_date', today.toIso8601String());
    _lastOpenDate = today;
    final raw = prefs.getStringList('word_progress') ?? [];
    for (final s in raw) {
      final wp = WordProgress.fromJson(jsonDecode(s));
      _progress[wp.wordId] = wp;
    }
    final streakRaw = prefs.getString('streaks') ?? '{}';
    final decoded = jsonDecode(streakRaw) as Map<String, dynamic>;
    _streaks = decoded.map((k, v) => MapEntry(k, v as int));
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('word_progress',
        _progress.values.map((wp) => jsonEncode(wp.toJson())).toList());
    await prefs.setString('streaks', jsonEncode(_streaks));
  }

  List<Word> buildSession(String categoryId, {int batchSize = 20}) {
    final all = wordsForCategory(categoryId);
    final reviewWords = <Word>[];
    final newWords = <Word>[];
    for (final word in all) {
      final wp = _progress[word.id];
      if (wp == null || wp.learnedOnDay < 0) {
        newWords.add(word);
      } else if (!wp.mastered && _currentDay >= wp.learnedOnDay + 2) {
        reviewWords.add(word);
      }
    }
    final session = <Word>[];
    session.addAll(reviewWords.take(batchSize));
    if (session.length < batchSize) {
      session.addAll(newWords.take(batchSize - session.length));
    }
    return session;
  }

  bool hasReviewDue(String categoryId) {
    return wordsForCategory(categoryId).any((w) {
      final wp = _progress[w.id];
      return wp != null && wp.learnedOnDay >= 0 && !wp.mastered && _currentDay >= wp.learnedOnDay + 2;
    });
  }

  void markGotIt(String wordId, String categoryId) {
    final wp = _progress[wordId] ?? WordProgress(wordId: wordId, category: categoryId);
    wp.gotItCount++;
    wp.lastSeen = DateTime.now();
    if (wp.learnedOnDay < 0) {
      wp.learnedOnDay = _currentDay;
    } else if (_currentDay >= wp.learnedOnDay + 2) {
      wp.mastered = true;
    }
    _progress[wordId] = wp;
    _streaks[categoryId] = (_streaks[categoryId] ?? 0) + 1;
    _save();
    notifyListeners();
  }

  void markNotYet(String wordId, String categoryId) {
    final wp = _progress[wordId] ?? WordProgress(wordId: wordId, category: categoryId);
    wp.notYetCount++;
    wp.lastSeen = DateTime.now();
    wp.learnedOnDay = -1;
    wp.mastered = false;
    _progress[wordId] = wp;
    _save();
    notifyListeners();
  }

  int learnedCount(String categoryId) =>
      _progress.values.where((wp) => wp.category == categoryId && wp.learnedOnDay >= 0).length;

  int masteredCount(String categoryId) =>
      _progress.values.where((wp) => wp.category == categoryId && wp.mastered).length;

  int totalWordsInCategory(String categoryId) => wordsForCategory(categoryId).length;

  double categoryProgress(String categoryId) {
    final total = totalWordsInCategory(categoryId);
    return total == 0 ? 0 : masteredCount(categoryId) / total;
  }

  void resetCategory(String categoryId) {
    for (final key in _progress.keys.toList()) {
      if (_progress[key]!.category == categoryId) _progress.remove(key);
    }
    _streaks.remove(categoryId);
    _save();
    notifyListeners();
  }
}
