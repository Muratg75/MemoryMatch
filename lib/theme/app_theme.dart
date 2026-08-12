import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color tertiaryColor = Color(0xFF43D9AD);
  static const Color darkBackground = Color(0xFF2D2F41);
  static const Color lightText = Colors.white;
  static const Color darkText = Color(0xFF2D2F41);

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6C63FF),
      Color(0xFF4834D4),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6584),
      Color(0xFFFF80A0),
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2D2F41),
      Color(0xFF1F1D2B),
    ],
  );

  // Text Styles
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: lightText,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.3),
        offset: const Offset(0, 4),
        blurRadius: 8,
      ),
    ],
  );

  static TextStyle get displayMedium => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: lightText,
  );

  static TextStyle get bodyLarge => GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: lightText,
  );

  static TextStyle get bodyMedium => GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: lightText.withOpacity(0.8),
  );

  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: lightText,
  );
}
