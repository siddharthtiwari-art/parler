import 'package:flutter/material.dart';
import '../models/word.dart';
import '../utils/theme.dart';
import 'home_screen.dart';
import 'session_screen.dart';

class ResultsScreen extends StatelessWidget {
  final Category category;
  final int gotIt, notYet;
  final bool isRound2;

  const ResultsScreen({
    super.key,
    required this.category,
    required this.gotIt,
    required this.notYet,
    required this.isRound2,
  });

  @override
  Widget build(BuildContext context) {
    final total = gotIt + notYet;
    final score = total == 0 ? 0.0 : gotIt / total;
    final pct = (score * 100).round();
    final colors = catColorMap[category.id]!;

    String reaction;
    if (pct == 100) reaction = 'Parfait ! 🎉';
    else if (pct >= 80) reaction = 'Très bien ! 👏';
    else if (pct >= 60) reaction = 'Pas mal ! 💪';
    else reaction = 'Continue ! 📚';

    return Scaffold(
      backgroundColor: AC.bg(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            const SizedBox(height: 16),
            Text(
              'SESSION COMPLETE',
              style: TextStyle(
                color: AC.textMuted(context),
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 24),

            // Score circle
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.bg,
                border: Border.all(color: colors.border, width: 1.5),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('$pct%',
                    style: TextStyle(
                        color: colors.fg, fontSize: 28, fontWeight: FontWeight.w700)),
                Text('score', style: TextStyle(color: colors.muted, fontSize: 11)),
              ]),
            ),
            const SizedBox(height: 20),

            Text(reaction,
                style: TextStyle(
                    color: AC.textPrimary(context),
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(
              'You reviewed $total words in ${category.name}.',
              style: TextStyle(color: AC.textMuted(context), fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Stats row
            Row(children: [
              _StatCard(value: '$gotIt', label: 'Got it',    color: AppColors.green,  context: context),
              const SizedBox(width: 10),
              _StatCard(value: '$notYet', label: 'To review', color: AppColors.red,    context: context),
              const SizedBox(width: 10),
              _StatCard(value: '🔥',    label: 'Streak',    color: AppColors.amber,  context: context, isEmoji: true),
            ]),
            const SizedBox(height: 12),

            // Review reminder
            if (!isRound2 && notYet > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.amberBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.amberBorder, width: 0.5),
                ),
                child: Text(
                  '💡 $notYet missed words will come back in 2 days for review.',
                  style: const TextStyle(color: AppColors.amber, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),

            const Spacer(),

            _OutlineBtn(
              label: '↺  Practice this category again',
              fg: colors.fg, bg: colors.bg, border: colors.border,
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => SessionScreen(category: category))),
            ),
            const SizedBox(height: 10),
            _OutlineBtn(
              label: '← Back to categories',
              fg: AC.textMuted(context),
              bg: AC.bgCard(context),
              border: AC.border(context),
              onTap: () => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false),
            ),
          ]),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final Color color;
  final bool isEmoji;
  final BuildContext context;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.context,
    this.isEmoji = false,
  });

  @override
  Widget build(BuildContext _) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AC.bgCard(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AC.border(context), width: 0.5),
        ),
        child: Column(children: [
          if (isEmoji)
            Text(value, style: const TextStyle(fontSize: 20))
          else
            Text(value,
                style: TextStyle(
                    color: color, fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(label,
              style: TextStyle(color: AC.textMuted(context), fontSize: 10)),
        ]),
      ),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  final String label;
  final Color fg, bg, border;
  final VoidCallback onTap;

  const _OutlineBtn({
    required this.label,
    required this.fg,
    required this.bg,
    required this.border,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 0.5),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(
                color: fg, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
