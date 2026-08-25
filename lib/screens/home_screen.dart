import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/word.dart';
import '../services/progress_service.dart';
import '../utils/theme.dart';
import 'session_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final grouped = <String, List<Category>>{};
    for (final cat in categories) {
      grouped.putIfAbsent(cat.group, () => []).add(cat);
    }
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            _buildHeader(context, progress),
            const SizedBox(height: 24),
            ...grouped.entries.map((entry) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key.toUpperCase(),
                    style: const TextStyle(color: AppTheme.textMuted, fontSize: 10, letterSpacing: 0.8)),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.15,
                  children: entry.value
                      .map((cat) => _CategoryCard(cat: cat, progress: progress))
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProgressService progress) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('🇫🇷 Parler',
              style: TextStyle(color: AppTheme.textPrimary, fontSize: 26,
                  fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 2),
          const Text('What would you like to learn?',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        ]),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.bgCardBorder, width: 0.5),
          ),
          child: Row(children: [
            Text('${progress.totalStreak}',
                style: const TextStyle(color: AppTheme.amber, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(width: 6),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('🔥', style: TextStyle(fontSize: 14)),
              Text('streak', style: TextStyle(color: AppTheme.textMuted, fontSize: 9)),
            ]),
          ]),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category cat;
  final ProgressService progress;
  const _CategoryCard({required this.cat, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colors = catColorMap[cat.id]!;
    final pct = progress.categoryProgress(cat.id);
    final learned = progress.learnedCount(cat.id);
    final total = progress.totalWordsInCategory(cat.id);
    final hasReview = progress.hasReviewDue(cat.id);

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => SessionScreen(category: cat))),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colors.border, width: 0.8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(cat.emoji, style: const TextStyle(fontSize: 22)),
            const Spacer(),
            if (hasReview)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Review', style: TextStyle(color: AppTheme.amber, fontSize: 9)),
              ),
          ]),
          const Spacer(),
          Text(cat.name, style: TextStyle(color: colors.fg, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text('$learned / $total words', style: TextStyle(color: colors.muted, fontSize: 10)),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: pct, minHeight: 3,
              backgroundColor: colors.border,
              valueColor: AlwaysStoppedAnimation(colors.fg),
            ),
          ),
        ]),
      ),
    );
  }
}
