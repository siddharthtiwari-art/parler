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
    _index = 0; _revealed = false; _isRound2 = false; _gotIt = 0; _notYet = 0;
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
        _notYetWords = []; _index = 0; _revealed = false; _isRound2 = true;
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultsScreen(
          category: widget.category, gotIt: _gotIt, notYet: _notYet, isRound2: _isRound2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_session.isEmpty) {
      return Scaffold(
        backgroundColor: AppTheme.bg,
        body: const Center(child: Text('No words to study right now!',
            style: TextStyle(color: AppTheme.textMuted))),
      );
    }
    final colors = catColorMap[widget.category.id]!;
    final word = _currentWord;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppTheme.textMuted),
                onPressed: () => Navigator.pop(context),
              ),
              Text(widget.category.name, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
              const Spacer(),
              Text('${_index + 1} / ${_session.length}',
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 12, fontFamily: 'monospace')),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: (_index + 1) / _session.length, minHeight: 2,
                backgroundColor: AppTheme.bgCardBorder,
                valueColor: AlwaysStoppedAnimation(colors.fg),
              ),
            ),
          ),
          if (_isRound2)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.amber.withValues(alpha: 0.3), width: 0.5),
                ),
                child: const Text('🔁  Round 2 — reviewing missed words',
                    style: TextStyle(color: AppTheme.amber, fontSize: 11)),
              ),
            ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _revealed
                  ? _RevealedCard(word: word, colors: colors)
                  : _FrontCard(word: word, colors: colors, onReveal: () => setState(() => _revealed = true)),
            ),
          ),
          const SizedBox(height: 12),
          if (_revealed)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(children: [
                Expanded(child: _ActionBtn(label: '✕  Not yet', fg: AppTheme.red,
                    bg: AppTheme.redBg, border: AppTheme.redBorder, onTap: _onNotYet)),
                const SizedBox(width: 10),
                Expanded(child: _ActionBtn(label: '✓  Got it', fg: AppTheme.green,
                    bg: AppTheme.greenBg, border: AppTheme.greenBorder, onTap: _onGotIt)),
              ]),
            )
          else
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('Think of the meaning before revealing',
                  style: TextStyle(color: AppTheme.textDim, fontSize: 11)),
            ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}

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
        color: AppTheme.bgCard, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.bgCardBorder, width: 0.5),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: colors.bg, borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.border, width: 0.5)),
          child: Text('${_cap(word.category)} · ${word.gender}',
              style: TextStyle(color: colors.fg, fontSize: 10, letterSpacing: 0.3)),
        ),
        const SizedBox(height: 20),
        Text(word.french, textAlign: TextAlign.center,
            style: const TextStyle(color: AppTheme.textPrimary, fontSize: 36,
                fontWeight: FontWeight.w700, letterSpacing: -0.5)),
        const SizedBox(height: 6),
        Text(word.ipa,
            style: TextStyle(color: colors.fg.withValues(alpha: 0.7), fontSize: 14, fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Text(word.pronunciation,
            style: const TextStyle(color: AppTheme.textMuted, fontSize: 13, fontStyle: FontStyle.italic)),
        const SizedBox(height: 28),
        GestureDetector(
          onTap: onReveal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            decoration: BoxDecoration(color: colors.bg, borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border, width: 0.8)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.visibility_outlined, color: colors.fg, size: 16),
              const SizedBox(width: 8),
              Text('Show meaning', style: TextStyle(color: colors.fg, fontSize: 14, fontWeight: FontWeight.w500)),
            ]),
          ),
        ),
      ]),
    );
  }
  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

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
        color: AppTheme.bgCard, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.bgCardBorder, width: 0.5),
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: colors.bg, borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.border, width: 0.5)),
            child: Text('${_cap(word.category)} · ${word.gender}',
                style: TextStyle(color: colors.fg, fontSize: 10)),
          ),
          const SizedBox(height: 14),
          Text(word.french, textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 30,
                  fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(word.ipa,
              style: TextStyle(color: colors.fg.withValues(alpha: 0.7), fontSize: 13, fontFamily: 'monospace')),
          const SizedBox(height: 2),
          Text(word.pronunciation,
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 12, fontStyle: FontStyle.italic)),
          const SizedBox(height: 14),
          Container(height: 1, width: 40, color: AppTheme.bgCardBorder),
          const SizedBox(height: 14),
          Text(word.english, textAlign: TextAlign.center,
              style: TextStyle(color: colors.fg, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppTheme.bgHighlight, borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.bgCardBorder, width: 0.5)),
            child: Column(children: [
              Text('« ${word.exampleFr} »', textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13,
                      fontStyle: FontStyle.italic, height: 1.5)),
              const SizedBox(height: 6),
              Text('"${word.exampleEn}"', textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 11, height: 1.5)),
            ]),
          ),
        ]),
      ),
    );
  }
  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color fg, bg, border;
  final VoidCallback onTap;
  const _ActionBtn({required this.label, required this.fg, required this.bg, required this.border, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border, width: 0.8)),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
