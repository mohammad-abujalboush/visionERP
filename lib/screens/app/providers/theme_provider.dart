import 'package:flutter/material.dart';

class AppTheme {
  // New custom colors based on your palette
  static const Color diSerria = Color(0xFFdb9b4e);
  static const Color matisse = Color(0xFF196390);
  static const Color athensGray = Color(0xFFf1f1f2);
  static const Color jumbo = Color(0xFF79787a);
  static const Color mako = Color(0xFF40494f);
  static const Color hippieBlue = Color(0xFF6697b6);
  static const Color silverSand = Color(0xFFbfc2c6);
  static const Color dairyCream = Color(0xFFf9dab5);
  
  // Aliases for semantic usage (mapping old names to new colors)
  static const Color oxfordBlue = matisse;        // Primary blue
  static const Color white = athensGray;          // Background white
  static const Color buttonColor = diSerria;      // Primary button color
  static const Color iconColor = hippieBlue;      // Icon color
  static const Color rememberMeColor = diSerria;  // Checkbox color
  
  // Gradient colors using new palette
  static const List<Color> gradientColors = [
    diSerria,
    Color(0xFFe8b06e), // Lighter shade of diSerria
    Color(0xFFd18a3a), // Darker shade of diSerria
    Color(0xFFc47a2a), // Even darker shade
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      // Primary color scheme
      primaryColor: matisse,
      primaryColorDark: mako,
      primaryColorLight: hippieBlue,
      
      // Font family
      fontFamily: 'Cairo',
      
      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: matisse,
        secondary: diSerria,
        surface: athensGray,
        background: athensGray,
      ),
      
      // Scaffold background color
      scaffoldBackgroundColor: athensGray,
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: matisse,
        foregroundColor: athensGray,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: athensGray),
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: athensGray,
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: athensGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: silverSand),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: silverSand),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: matisse, width: 2),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: matisse,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Text theme with Cairo font and all weights
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          color: jumbo,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Cairo',
          color: jumbo,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Cairo',
          color: athensGray,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Cairo',
          color: mako,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Cairo',
          color: jumbo,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: diSerria,
          foregroundColor: athensGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          minimumSize: const Size(double.infinity, 50),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: matisse,
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return diSerria;
          }
          return silverSand;
        }),
        checkColor: WidgetStateProperty.all(athensGray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: silverSand,
        thickness: 1,
        space: 20,
      ),
      
      useMaterial3: true,
    );
  }
  
  // Custom gradient for backgrounds (kept for splash and intro screens)
  static BoxDecoration get gradientBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      ),
    );
  }

  // Custom text styles with Cairo font and all weights
  static TextStyle cairoTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = mako,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
    );
  }

  // Convenience methods for common font weights
  static TextStyle cairoLight({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w300, color: color, height: height);
  }

  static TextStyle cairoRegular({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w400, color: color, height: height);
  }

  static TextStyle cairoMedium({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: color, height: height);
  }

  static TextStyle cairoSemiBold({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: color, height: height);
  }

  static TextStyle cairoBold({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: color, height: height);
  }

  static TextStyle cairoExtraBold({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, color: color, height: height);
  }

  static TextStyle cairoBlack({double fontSize = 16, Color color = mako, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w900, color: color, height: height);
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = AppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}