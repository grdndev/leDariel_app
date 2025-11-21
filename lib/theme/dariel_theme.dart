import 'package:flutter/material.dart';

class DARIELTheme {
  // Couleurs principales
  static const Color accentRed = Color(0xFFCC1A1A); // Rouge pour les acronymes
  static const Color primaryColor = Color(0xFF664D99); // Indigo
  static const Color secondaryColor = Color(0xFFFAF5FF); // Fond clair
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;

  // Dégradés
  static const LinearGradient gradientBackground = LinearGradient(
    colors: [Color(0xFF664D99), Color(0xFFE66699)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Espacements
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;

  // Rayons de coins
  static const double cornerRadiusSmall = 12.0;
  static const double cornerRadiusMedium = 16.0;
  static const double cornerRadiusLarge = 24.0;

  // Ombres
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  // Polices
  static TextStyle titleFont({double size = 28}) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      );

  static TextStyle subtitleFont({double size = 20}) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
      );

  static TextStyle bodyFont({double size = 16}) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.normal,
      );

  static TextStyle captionFont({double size = 14}) => TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w500,
      );

  // Thème de l'application
  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentRed,
        ),
        scaffoldBackgroundColor: secondaryColor,
        cardTheme: CardTheme(
          color: cardBackground,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadiusMedium),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadiusSmall),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadiusSmall),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadiusSmall),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: spacingLarge,
              vertical: spacingMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadiusSmall),
            ),
          ),
        ),
        useMaterial3: true,
      );
}

// Extensions pour faciliter l'utilisation du thème
extension DARIELCardStyle on Widget {
  Widget darielCardStyle() {
    return Container(
      padding: const EdgeInsets.all(DARIELTheme.spacingMedium),
      decoration: BoxDecoration(
        color: DARIELTheme.cardBackground,
        borderRadius: BorderRadius.circular(DARIELTheme.cornerRadiusMedium),
        boxShadow: DARIELTheme.shadowMedium,
      ),
      child: this,
    );
  }
}

