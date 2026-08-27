import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/word.dart';
import '../services/progress_service.dart';
import '../utils/theme.dart';
import 'results_screen.dart';

class SessionScreen extends StatefulWidget {
  final Category category;
  const SessionScreen({super.key, required this.category});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  List<Word> _session = [];
  List<Word> _notYetWords = [];
  int _index = 0;
  bool _revealed = false;
  bool _isRound2 = false;
  int _gotIt = 0, _notYet = 0;

  @override
  void initState() {
    super.initState();
    _buildSession();
  }

  void _buildSession() {
    final svc = context.read<ProgressService>();
    _session = svc.buildSession(widget.category.id);
    _notYetWords = [];
    _index = 0;
    _revealed = false;
    _isRound2 = false;
    _gotIt = 0;
    _notYet = 0;
  }

  Word get _currentWord => _session[_index];

  void _onGotIt() {
    context.read<ProgressService>().markGotIt(_currentWord.id, widget.category.id);
    _gotIt++;
    _advance();
  }

  void _onNotYet() {
    context.read<ProgressService>().markNotYet(_currentWord.id, widget.category.id);
    _notYetWords.add(_currentWord);
    _notYet++;
    _advance();
  }

  void _advance() {
    if (_index + 1 < _session.length) {
      setState(() { _index++; _revealed = false; });
    } else if (!_isRound2 && _notYetWords.isNotEmpty) {
      setState(() {
        _session = List.from(_notYetWords);
        _notYetWords = [];
        _index = 0;
        _revealed = false;
        _isRound2 = true;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultsScreen(
            category: widget.category,
            gotIt: _gotIt,
            notYet: _notYet,
            isRound2: _isRound2,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session.isEmpty) {
      return Scaffold(
        backgroundColor: AC.bg(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('🎉', style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text('All caught up!',
                  style: TextStyle(
                      color: AC.textPrimary(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('No words to study right now.\nCome back tomorrow for your review.',
                  style: TextStyle(color: AC.textMuted(context), fontSize: 14),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: catColorMap[widget.category.id]!.bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: catColorMap[widget.category.id]!.border),
                  ),
                  child: Text('← Back',
                      style: TextStyle(
                          color: catColorMap[widget.category.id]!.fg,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ]),
          ),
        ),
      );
    }

    final colors = catColorMap[widget.category.id]!;
    final word = _currentWord;

    return Scaffold(
      backgroundColor: AC.bg(context),
      body: SafeArea(
        child: Column(children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AC.textMuted(context)),
                onPressed: () => Navigator.pop(context),
              ),
              Text(widget.category.name,
                  style: TextStyle(color: AC.textMuted(context), fontSize: 13)),
              const Spacer(),
              Text('${_index + 1} / ${_session.length}',
                  style: TextStyle(
                      color: AC.textMuted(context),
                      fontSize: 12,
                      fontFamily: 'monospace')),
            ]),
          ),

          // Progress bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: (_index + 1) / _session.length,
                minHeight: 2,
                backgroundColor: AC.border(context),
                valueColor: AlwaysStoppedAnimation(colors.fg),
              ),
            ),
          ),

          // Round 2 badge
          if (_isRound2)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.amberBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.amberBorder, width: 0.5),
                ),
                child: const Text('🔁  Round 2 — reviewing missed words',
                    style: TextStyle(color: AppColors.amber, fontSize: 11)),
              ),
            ),

          const SizedBox(height: 12),

          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _revealed
                  ? _RevealedCard(word: word, colors: colors)
                  : _FrontCard(
                      word: word,
                      colors: colors,
                      onReveal: () => setState(() => _revealed = true),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Buttons
          if (_revealed)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(children: [
                Expanded(
                  child: _ActionBtn(
                    label: '✕  Not yet',
                    fg: AppColors.red,
                    bg: AppColors.redBg,
                    border: AppColors.redBorder,
                    onTap: _onNotYet,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ActionBtn(
                    label: '✓  Got it',
                    fg: AppColors.green,
                    bg: AppColors.greenBg,
                    border: AppColors.greenBorder,
                    onTap: _onGotIt,
                  ),
                ),
              ]),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Think of the meaning before revealing',
                style: TextStyle(color: AC.textMuted(context), fontSize: 11),
              ),
            ),

          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}

// ── Front card ───────────────────────────────────────────────────────────────

class _FrontCard extends StatelessWidget {
  final Word word;
  final CatColors colors;
  final VoidCallback onReveal;

  const _FrontCard({required this.word, required this.colors, required this.onReveal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AC.bgCard(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AC.border(context), width: 0.5),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colors.bg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.border, width: 0.5),
          ),
          child: Text(
            '${_cap(word.category)} · ${word.gender}',
            style: TextStyle(color: colors.fg, fontSize: 10, letterSpacing: 0.3),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          word.french,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AC.textPrimary(context),
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          word.ipa,
          style: TextStyle(
            color: colors.fg.withValues(alpha: 0.7),
            fontSize: 14,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          word.pronunciation,
          style: TextStyle(
            color: AC.textMuted(context),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 28),
        GestureDetector(
          onTap: onReveal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            decoration: BoxDecoration(
              color: colors.bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border, width: 0.8),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.visibility_outlined, color: colors.fg, size: 16),
              const SizedBox(width: 8),
              Text('Show meaning',
                  style: TextStyle(
                      color: colors.fg,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            ]),
          ),
        ),
      ]),
    );
  }

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

// ── Revealed card ─────────────────────────────────────────────────────────────

class _RevealedCard extends StatelessWidget {
  final Word word;
  final CatColors colors;

  const _RevealedCard({required this.word, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AC.bgCard(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AC.border(context), width: 0.5),
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: colors.bg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.border, width: 0.5),
            ),
            child: Text('${_cap(word.category)} · ${word.gender}',
                style: TextStyle(color: colors.fg, fontSize: 10)),
          ),
          const SizedBox(height: 14),
          Text(
            word.french,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AC.textPrimary(context),
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            word.ipa,
            style: TextStyle(
              color: colors.fg.withValues(alpha: 0.7),
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            word.pronunciation,
            style: TextStyle(
              color: AC.textMuted(context),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          Divider(color: AC.border(context), thickness: 0.5),
          const SizedBox(height: 14),
          Text(
            word.english,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: colors.fg, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AC.bgHighlight(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AC.border(context), width: 0.5),
            ),
            child: Column(children: [
              Text(
                '« ${word.exampleFr} »',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AC.textSecondary(context),
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '"${word.exampleEn}"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AC.textMuted(context),
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

// ── Action button ─────────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color fg, bg, border;
  final VoidCallback onTap;

  const _ActionBtn({
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 0.8),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(
                color: fg, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
