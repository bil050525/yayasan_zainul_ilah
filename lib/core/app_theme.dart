import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1B5E20); // Deep Emerald
  static const Color secondaryColor = Color(0xFF0D47A1); // Navy Blue
  static const Color accentColor = Color(0xFFFFA000); // Amber
  static const Color backgroundColor = Color(0xFFF8F9FA); // Off White
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static ThemeData get lightTheme {
    return _buildTheme(Brightness.light);
  }

  static ThemeData get darkTheme {
    return _buildTheme(Brightness.dark);
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: isDark ? const Color(0xFF121212) : surfaceColor,
        background: isDark ? const Color(0xFF121212) : backgroundColor,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : backgroundColor,
      textTheme: GoogleFonts.interTextTheme(
        isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : textPrimary,
          letterSpacing: -0.5,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: isDark ? Colors.white70 : textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: isDark ? Colors.white60 : textSecondary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? const Color(0xFF1F1F1F) : surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
          ),
        ),
      ),
    );
  }
}
