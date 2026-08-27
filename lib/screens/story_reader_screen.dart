import 'package:flutter/material.dart';
import '../models/story.dart';
import '../utils/theme.dart';

class StoryReaderScreen extends StatefulWidget {
  final Story story;
  const StoryReaderScreen({super.key, required this.story});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  int _pageIndex = 0;
  StoryWord? _activeWord;
  final PageController _pageCtrl = PageController();

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    setState(() { _pageIndex = index; _activeWord = null; });
    _pageCtrl.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final colors = catColorMap[widget.story.category] ?? catColorMap['stories']!;
    final bg = AC.bg(context);
    final textPrimary = AC.textPrimary(context);
    final textMuted = AC.textMuted(context);
    final totalPages = widget.story.pages.length;

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: textMuted),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.story.title,
                                style: TextStyle(color: textPrimary,
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            Text(widget.story.titleEn,
                                style: TextStyle(color: textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                      Text('${_pageIndex + 1} / $totalPages',
                          style: TextStyle(color: textMuted, fontSize: 12, fontFamily: 'monospace')),
                    ],
                  ),
                ),

                // Progress dots
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalPages, (i) => GestureDetector(
                      onTap: () => _goToPage(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _pageIndex ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _pageIndex ? colors.fg : colors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )),
                  ),
                ),

                // Page content
                Expanded(
                  child: PageView.builder(
                    controller: _pageCtrl,
                    itemCount: totalPages,
                    onPageChanged: (i) => setState(() { _pageIndex = i; _activeWord = null; }),
                    itemBuilder: (_, i) => _StoryPageView(
                      page: widget.story.pages[i],
                      colors: colors,
                      onWordTap: (w) => setState(() => _activeWord = w),
                    ),
                  ),
                ),

                // Nav buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      if (_pageIndex > 0)
                        Expanded(
                          child: _NavBtn(
                            label: '← Previous',
                            fg: colors.fg, bg: colors.bg, border: colors.border,
                            onTap: () => _goToPage(_pageIndex - 1),
                          ),
                        ),
                      if (_pageIndex > 0) const SizedBox(width: 10),
                      if (_pageIndex < totalPages - 1)
                        Expanded(
                          child: _NavBtn(
                            label: 'Next →',
                            fg: colors.fg, bg: colors.bg, border: colors.border,
                            onTap: () => _goToPage(_pageIndex + 1),
                          ),
                        ),
                      if (_pageIndex == totalPages - 1)
                        Expanded(
                          child: _NavBtn(
                            label: '✓  Finished',
                            fg: AppColors.green, bg: AppColors.greenBg, border: AppColors.greenBorder,
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Word popup overlay
          if (_activeWord != null)
            _WordPopup(
              word: _activeWord!,
              onDismiss: () => setState(() => _activeWord = null),
            ),
        ],
      ),
    );
  }
}

// ── Story page — rich text with tappable words ──────────────────────────────

class _StoryPageView extends StatelessWidget {
  final StoryPage page;
  final CatColors colors;
  final ValueChanged<StoryWord> onWordTap;

  const _StoryPageView({
    required this.page,
    required this.colors,
    required this.onWordTap,
  });

  @override
  Widget build(BuildContext context) {
    final textPrimary = AC.textPrimary(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AC.bgCard(context),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AC.border(context), width: 0.5),
        ),
        child: _buildRichText(context, textPrimary),
      ),
    );
  }

  Widget _buildRichText(BuildContext context, Color textColor) {
    // Build a list of TextSpan — normal text and tappable word spans
    final spans = <InlineSpan>[];
    String remaining = page.text;

    // Sort words by their position in text
    final sortedWords = [...page.words];
    // We'll scan through the text and find each word occurrence
    final List<_TextSegment> segments = _buildSegments(remaining, sortedWords);

    for (final seg in segments) {
      if (seg.word == null) {
        spans.add(TextSpan(
          text: seg.text,
          style: TextStyle(color: textColor, fontSize: 15, height: 1.75),
        ));
      } else {
        final sw = seg.word!;
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: GestureDetector(
            onTap: () => onWordTap(sw),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.fg, width: 1.5)),
              ),
              child: Text(
                seg.text,
                style: TextStyle(
                  color: colors.fg,
                  fontSize: 15,
                  height: 1.75,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ));
      }
    }

    return RichText(text: TextSpan(children: spans));
  }

  List<_TextSegment> _buildSegments(String text, List<StoryWord> words) {
    final segments = <_TextSegment>[];
    // Find all word positions
    final matches = <_Match>[];
    for (final sw in words) {
      int start = 0;
      while (true) {
        final idx = text.indexOf(sw.french, start);
        if (idx == -1) break;
        matches.add(_Match(start: idx, end: idx + sw.french.length, word: sw));
        start = idx + sw.french.length;
      }
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    // Remove overlaps
    final clean = <_Match>[];
    int cursor = 0;
    for (final m in matches) {
      if (m.start >= cursor) { clean.add(m); cursor = m.end; }
    }

    // Build segments
    cursor = 0;
    for (final m in clean) {
      if (m.start > cursor) {
        segments.add(_TextSegment(text: text.substring(cursor, m.start)));
      }
      segments.add(_TextSegment(text: text.substring(m.start, m.end), word: m.word));
      cursor = m.end;
    }
    if (cursor < text.length) {
      segments.add(_TextSegment(text: text.substring(cursor)));
    }
    return segments;
  }
}

class _TextSegment { final String text; final StoryWord? word; _TextSegment({required this.text, this.word}); }
class _Match { final int start, end; final StoryWord word; _Match({required this.start, required this.end, required this.word}); }

// ── Word popup ──────────────────────────────────────────────────────────────

class _WordPopup extends StatelessWidget {
  final StoryWord word;
  final VoidCallback onDismiss;

  const _WordPopup({required this.word, required this.onDismiss});

  // Pastel popup colours — distinct from category colours
  static const Color popupBg     = Color(0xFFFFF3E8);   // warm peach
  static const Color popupBorder = Color(0xFFEDD5B8);
  static const Color popupFg     = Color(0xFF8B5E3C);
  static const Color popupMuted  = Color(0xFFB8895A);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Container(
        color: Colors.black.withValues(alpha: 0.35),
        child: SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {}, // don't dismiss on card tap
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                decoration: BoxDecoration(
                  color: popupBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: popupBorder, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            word.french,
                            style: const TextStyle(
                              color: popupFg,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onDismiss,
                          child: const Icon(Icons.close_rounded, color: popupMuted, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      word.pronunciation,
                      style: const TextStyle(
                          color: popupMuted, fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: popupBorder),
                    const SizedBox(height: 10),
                    Text(
                      word.english,
                      style: const TextStyle(
                          color: popupFg, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav button ──────────────────────────────────────────────────────────────

class _NavBtn extends StatelessWidget {
  final String label;
  final Color fg, bg, border;
  final VoidCallback onTap;

  const _NavBtn({required this.label, required this.fg, required this.bg,
    required this.border, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 0.8),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

