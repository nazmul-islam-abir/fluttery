import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Fluttery design system — BLACK & WHITE, minimal, no futuristic effects.
// Rules: white background, black text, 1px black/grey borders,
// square-ish corners (radius 10 max), no gradients, no neon, no glass.

class FlutteryTheme {
  static const black = Color(0xFF111111);
  static const white = Color(0xFFFFFFFF);
  static const darkHeader = Color(0xFF0B132B);
  static const tealBrand = Color(0xFF064E3B);
  static const grey900 = Color(0xFF111827);
  static const grey700 = Color(0xFF374151);
  static const grey500 = Color(0xFF6B7280);
  static const grey300 = Color(0xFFD1D5DB);
  static const grey200 = Color(0xFFE5E7EB);
  static const grey100 = Color(0xFFF3F4F6);
  static const grey50 = Color(0xFFF9FAFB);

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: grey50,
      colorScheme: const ColorScheme.light(
        primary: black,
        onPrimary: white,
        secondary: black,
        surface: white,
        onSurface: black,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.inter(
            fontSize: 48, fontWeight: FontWeight.w800, color: black, height: 1.08),
        headlineMedium: GoogleFonts.inter(
            fontSize: 32, fontWeight: FontWeight.w800, color: black, height: 1.15),
        titleLarge: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.w700, color: black),
        titleMedium: GoogleFonts.inter(
            fontSize: 17, fontWeight: FontWeight.w600, color: black),
        bodyLarge: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w400, color: grey900, height: 1.6),
        bodyMedium: GoogleFonts.inter(
            fontSize: 15, fontWeight: FontWeight.w400, color: grey700, height: 1.6),
        labelLarge: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w600, color: black),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: black,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: black,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: black,
          side: const BorderSide(color: black, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: black, width: 1.5),
        ),
      ),
      dividerColor: grey200,
    );
  }

  // Shared card style — crisp border, soft depth.
  static BoxDecoration card = BoxDecoration(
    color: white,
    border: Border.all(color: grey200),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 14,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration cardHover = BoxDecoration(
    color: white,
    border: Border.all(color: black, width: 1.2),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
