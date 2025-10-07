import 'package:flutter/material.dart';

class AppTheme {
  // Custom colors
  static const Color oxfordBlue = Color(0xFF002147);
  static const Color white = Color(0xFFFFFFFF);
  static const Color buttonColor = Color(0xFF05465f);
  static const Color iconColor = Color(0xFF8fb9c8);
  static const Color rememberMeColor = Colors.orange;
  
  // Gradient colors
  static const List<Color> gradientColors = [
    Color(0xFFf5ba6e),
    Color(0xFFfcbc50),
    Color(0xFFf4a749),
    Color(0xFFd38430),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      // Primary color scheme
      primaryColor: oxfordBlue,
      primaryColorDark: buttonColor,
      primaryColorLight: iconColor,
      
      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: oxfordBlue,
        secondary: buttonColor,
        surface: white,
        background: white,
      ),
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: oxfordBlue,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: white),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: oxfordBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: oxfordBlue, width: 2),
        ),
        labelStyle: const TextStyle(color: oxfordBlue),
        floatingLabelStyle: const TextStyle(color: oxfordBlue),
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: oxfordBlue,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: oxfordBlue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: oxfordBlue,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: oxfordBlue,
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return rememberMeColor;
          }
          return oxfordBlue.withOpacity(0.5);
        }),
        checkColor: MaterialStateProperty.all(white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: oxfordBlue.withOpacity(0.3),
        thickness: 1,
        space: 20,
      ),
      
      useMaterial3: true,
    );
  }
  
  // Custom gradient for backgrounds
  static BoxDecoration get gradientBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ),
    );
  }
}