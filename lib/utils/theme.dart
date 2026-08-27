import 'package:flutter/material.dart';

// ── Static color tokens (same in both themes) ──────────────────────────────

class AppColors {
  // Accent greens / reds / etc — same in both themes
  static const Color green       = Color(0xFF2DB87A);
  static const Color greenBg     = Color(0xFFEBF8F2);
  static const Color greenBorder = Color(0xFFB2E8D0);
  static const Color red         = Color(0xFFE03E49);
  static const Color redBg       = Color(0xFFFDECED);
  static const Color redBorder   = Color(0xFFF5B8BB);
  static const Color amber       = Color(0xFFD4982A);
  static const Color amberBg     = Color(0xFFFDF6E3);
  static const Color amberBorder = Color(0xFFF0D9A0);

  // Category colours — same in both themes
  static const Color purple       = Color(0xFF7C6EE8);
  static const Color purpleBg     = Color(0xFFF0EEFF);
  static const Color purpleBorder = Color(0xFFCDC6F8);
  static const Color purpleMuted  = Color(0xFF9D92E0);

  static const Color teal         = Color(0xFF2BA88A);
  static const Color tealBg       = Color(0xFFE8F7F3);
  static const Color tealBorder   = Color(0xFFB2DFD4);
  static const Color tealMuted    = Color(0xFF5CBFAA);

  static const Color coral        = Color(0xFFE07050);
  static const Color coralBg      = Color(0xFFFDF0EB);
  static const Color coralBorder  = Color(0xFFF5C8B8);
  static const Color coralMuted   = Color(0xFFD09080);

  static const Color amberCat     = Color(0xFFB88A20);
  static const Color amberCatBg   = Color(0xFFFDF6E3);
  static const Color amberCatBorder= Color(0xFFEDD898);
  static const Color amberCatMuted = Color(0xFFD4A840);

  static const Color pink         = Color(0xFFD0608A);
  static const Color pinkBg       = Color(0xFFFCEEF4);
  static const Color pinkBorder   = Color(0xFFF0C0D8);
  static const Color pinkMuted    = Color(0xFFD890B0);

  static const Color blue         = Color(0xFF4A9EE0);
  static const Color blueBg       = Color(0xFFEBF4FD);
  static const Color blueBorder   = Color(0xFFB8D8F5);
  static const Color blueMuted    = Color(0xFF70B8E8);

  static const Color story        = Color(0xFF8A70C8);
  static const Color storyBg      = Color(0xFFF3F0FF);
  static const Color storyBorder  = Color(0xFFD0C8F8);
  static const Color storyMuted   = Color(0xFFAA98D8);
}

// ── Category color bundle ──────────────────────────────────────────────────

class CatColors {
  final Color fg, bg, border, muted;
  const CatColors({required this.fg, required this.bg, required this.border, required this.muted});
}

const Map<String, CatColors> catColorMap = {
  'greetings': CatColors(fg: AppColors.purple,    bg: AppColors.purpleBg,     border: AppColors.purpleBorder,    muted: AppColors.purpleMuted),
  'food':      CatColors(fg: AppColors.teal,      bg: AppColors.tealBg,       border: AppColors.tealBorder,      muted: AppColors.tealMuted),
  'travel':    CatColors(fg: AppColors.coral,     bg: AppColors.coralBg,      border: AppColors.coralBorder,     muted: AppColors.coralMuted),
  'shopping':  CatColors(fg: AppColors.amberCat,  bg: AppColors.amberCatBg,   border: AppColors.amberCatBorder,  muted: AppColors.amberCatMuted),
  'emotions':  CatColors(fg: AppColors.pink,      bg: AppColors.pinkBg,       border: AppColors.pinkBorder,      muted: AppColors.pinkMuted),
  'business':  CatColors(fg: AppColors.blue,      bg: AppColors.blueBg,       border: AppColors.blueBorder,      muted: AppColors.blueMuted),
  'stories':   CatColors(fg: AppColors.story,     bg: AppColors.storyBg,      border: AppColors.storyBorder,     muted: AppColors.storyMuted),
};

// ── Dynamic color helpers (use these everywhere instead of hardcoded colors) 

class AC {
  // Call these with a BuildContext — adapts to light/dark automatically
  static Color bg(BuildContext ctx)         => Theme.of(ctx).colorScheme.surface;
  static Color bgCard(BuildContext ctx)     => Theme.of(ctx).colorScheme.surfaceContainerLow;
  static Color bgHighlight(BuildContext ctx)=> Theme.of(ctx).colorScheme.surfaceContainerHighest;
  static Color border(BuildContext ctx)     => Theme.of(ctx).colorScheme.outlineVariant;
  static Color textPrimary(BuildContext ctx)=> Theme.of(ctx).colorScheme.onSurface;
  static Color textSecondary(BuildContext ctx)=> Theme.of(ctx).colorScheme.onSurfaceVariant;
  static Color textMuted(BuildContext ctx)  => Theme.of(ctx).colorScheme.outline;
}

// ── Theme definitions ──────────────────────────────────────────────────────

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      brightness: Brightness.light,
    ).copyWith(
      surface: const Color(0xFFFAFAFC),
      surfaceContainerLow: Colors.white,
      surfaceContainerHighest: const Color(0xFFF0F0F5),
      outlineVariant: const Color(0xFFE0E0E8),
      outline: const Color(0xFFAAAAAA),
      onSurface: const Color(0xFF1A1A2E),
      onSurfaceVariant: const Color(0xFF555570),
    ),
    scaffoldBackgroundColor: const Color(0xFFFAFAFC),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFAFAFC),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFAAAAAA)),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: const Color(0xFFE0E0E8), width: 0.5),
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF0E0F13),
      surfaceContainerLow: const Color(0xFF13151D),
      surfaceContainerHighest: const Color(0xFF1A1D26),
      outlineVariant: const Color(0xFF1E2130),
      outline: const Color(0xFF555A6B),
      onSurface: const Color(0xFFE8EAF0),
      onSurfaceVariant: const Color(0xFFA0A5BB),
    ),
    scaffoldBackgroundColor: const Color(0xFF0E0F13),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0E0F13),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF555A6B)),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF13151D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: const Color(0xFF1E2130), width: 0.5),
      ),
    ),
  );
}
