import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF0E0F13);
  static const Color bgCard = Color(0xFF13151D);
  static const Color bgCardBorder = Color(0xFF1E2130);
  static const Color bgHighlight = Color(0xFF1A1D26);
  static const Color textPrimary = Color(0xFFE8EAF0);
  static const Color textSecondary = Color(0xFFA0A5BB);
  static const Color textMuted = Color(0xFF555A6B);
  static const Color textDim = Color(0xFF3A3D4A);
  static const Color purple = Color(0xFFB8A8F8);
  static const Color purpleDark = Color(0xFF8070C8);
  static const Color purpleBg = Color(0xFF1A1535);
  static const Color purpleBorder = Color(0xFF2E2660);
  static const Color teal = Color(0xFF5DCAA5);
  static const Color tealBg = Color(0xFF0E1F1A);
  static const Color tealBorder = Color(0xFF1A3D30);
  static const Color coral = Color(0xFFF0997B);
  static const Color coralBg = Color(0xFF1F130E);
  static const Color coralBorder = Color(0xFF3D2218);
  static const Color amber = Color(0xFFF0C040);
  static const Color amberBg = Color(0xFF1F1A0A);
  static const Color amberBorder = Color(0xFF3D320F);
  static const Color pink = Color(0xFFED93B1);
  static const Color pinkBg = Color(0xFF1F0E17);
  static const Color pinkBorder = Color(0xFF3D1A2E);
  static const Color blue = Color(0xFF6AB4FF);
  static const Color blueBg = Color(0xFF0E1520);
  static const Color blueBorder = Color(0xFF1A2E45);
  static const Color green = Color(0xFF3ECF8E);
  static const Color greenBg = Color(0xFF0E1F16);
  static const Color greenBorder = Color(0xFF1A3D28);
  static const Color red = Color(0xFFF04C57);
  static const Color redBg = Color(0xFF1F0E0E);
  static const Color redBorder = Color(0xFF3D1A1A);
  static const Color divider = Color(0xFF252730);

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: purple,
          secondary: teal,
          surface: bgCard,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          elevation: 0,
          iconTheme: IconThemeData(color: textMuted),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
        ),
      );
}

class CatColors {
  final Color fg, bg, border, muted;
  const CatColors({required this.fg, required this.bg, required this.border, required this.muted});
}

const Map<String, CatColors> catColorMap = {
  'greetings': CatColors(fg: AppTheme.purple, bg: AppTheme.purpleBg, border: AppTheme.purpleBorder, muted: AppTheme.purpleDark),
  'food':      CatColors(fg: AppTheme.teal,   bg: AppTheme.tealBg,   border: AppTheme.tealBorder,   muted: Color(0xFF3A8A70)),
  'travel':    CatColors(fg: AppTheme.coral,  bg: AppTheme.coralBg,  border: AppTheme.coralBorder,  muted: Color(0xFFA05540)),
  'shopping':  CatColors(fg: AppTheme.amber,  bg: AppTheme.amberBg,  border: AppTheme.amberBorder,  muted: Color(0xFFA08020)),
  'emotions':  CatColors(fg: AppTheme.pink,   bg: AppTheme.pinkBg,   border: AppTheme.pinkBorder,   muted: Color(0xFFA05070)),
  'business':  CatColors(fg: AppTheme.blue,   bg: AppTheme.blueBg,   border: AppTheme.blueBorder,   muted: Color(0xFF4070A0)),
};
