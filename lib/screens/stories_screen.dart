import 'package:flutter/material.dart';
import '../data/stories_data.dart';
import '../models/story.dart';
import '../utils/theme.dart';
import 'story_reader_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bg = AC.bg(context);
    final textPrimary = AC.textPrimary(context);
    final textMuted = AC.textMuted(context);
    final border = AC.border(context);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Text('📖  Stories',
                      style: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
              child: Text(
                'Tap a word inside any story to see its meaning.',
                style: TextStyle(color: textMuted, fontSize: 12),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                itemCount: allStories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _StoryCard(story: allStories[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Story story;
  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    final colors = catColorMap[story.category] ?? catColorMap['stories']!;
    final textMuted = AC.textMuted(context);

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => StoryReaderScreen(story: story))),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border, width: 0.8),
        ),
        child: Row(
          children: [
            Text(story.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(story.title,
                      style: TextStyle(
                          color: colors.fg,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(story.titleEn,
                      style: TextStyle(color: colors.muted, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(story.teaser,
                      style: TextStyle(color: textMuted, fontSize: 12, height: 1.4)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _pill(colors, '${story.pages.length} pages'),
                      const SizedBox(width: 6),
                      _pill(colors, _wordCount(story)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded, color: colors.muted, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _pill(CatColors colors, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.border.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: colors.fg, fontSize: 10)),
    );
  }

  String _wordCount(Story story) {
    final total = story.pages.fold(0, (sum, p) => sum + p.words.length);
    return '$total vocab words';
  }
}

