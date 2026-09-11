import 'package:flutter/material.dart';

/// True black (#000000, not just "dark grey") so AMOLED panels turn those
/// pixels fully off — the whole point of a bedside clock app. Accent color
/// leans warm/red rather than blue to keep it easier on the eyes at night.
class AmoledTheme {
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0A0A0A);
  static const Color accent = Color(0xFFFF6B4A); // warm ember, not blue
  static const Color dimText = Color(0xFF4A4A4A);
  static const Color primaryText = Color(0xFFE8E8E8);

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          surface: surface,
          onSurface: primaryText,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: primaryText,
            fontWeight: FontWeight.w200,
            letterSpacing: 2,
          ),
          bodyMedium: TextStyle(color: dimText),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: accent,
          inactiveTrackColor: surface,
          thumbColor: accent,
        ),
      );
}
