import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /* ==========================================================
    VIPS VERITAS COLOR SYSTEM (HIGH CONTRAST VERSION)
     ========================================================== */

  static const Color bgLight = Color(0xFFF1F3E0);
  static const Color softSage = Color(0xFFD2DCB6);
  static const Color pastelGreen = Color(0xFFA1BC98);

  /// darker readable greens
  static const Color primaryText = Color(0xFF2F3E34);
  static const Color secondaryText = Color(0xFF4F5F55);

  /* ==========================================================
   GLOBAL APP GRADIENT
     ========================================================== */

  static const LinearGradient appGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgLight, softSage, pastelGreen],
  );

  /* ==========================================================
    GLASS EFFECT (USED EVERYWHERE)
     ========================================================== */

  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.28),
    borderRadius: BorderRadius.circular(22),
    border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );

  /* ==========================================================
    MAIN THEME
     ========================================================== */

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: pastelGreen,
      brightness: Brightness.light,
    ),

    /* ================= GLOBAL FONT ================= */
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: primaryText,
        letterSpacing: 0.4,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        height: 1.7,
        color: primaryText,
        fontWeight: FontWeight.w600, // ✅ typed text bold everywhere
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        color: secondaryText,
        fontWeight: FontWeight.w500,
      ),
    ),

    /* ================= APP BAR ================= */
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryText,
      ),
      iconTheme: const IconThemeData(color: primaryText),
    ),

    /* ================= INPUT FIELDS ================= */
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.92),
      labelStyle: GoogleFonts.plusJakartaSans(
        color: secondaryText,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: secondaryText.withOpacity(0.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: pastelGreen, width: 1.6),
      ),
    ),

    /* ================= BUTTONS ================= */
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pastelGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),

    /* ================= NAVBAR ================= */
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white.withOpacity(0.35),
      selectedItemColor: primaryText,
      unselectedItemColor: primaryText.withOpacity(0.5),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
      ),
    ),

    /* ================= DIALOGS ================= */
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),

    /* ================= CARDS ================= */
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),

    /* ================= CURSOR ================= */
    textSelectionTheme: const TextSelectionThemeData(cursorColor: primaryText),
  );
}
