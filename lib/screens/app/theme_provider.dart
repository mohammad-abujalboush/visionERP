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
      
      // Font family
      fontFamily: 'Cairo',
      
      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: oxfordBlue,
        secondary: buttonColor,
        surface: white,
      ),
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: oxfordBlue,
        foregroundColor: white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: white),
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
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
        labelStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: const TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Text theme with Cairo font and all weights
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Cairo',
          color: white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Cairo',
          color: oxfordBlue,
          fontSize: 12,
          fontWeight: FontWeight.w400,
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
          foregroundColor: oxfordBlue,
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
            return rememberMeColor;
          }
          return oxfordBlue.withOpacity(0.5);
        }),
        checkColor: WidgetStateProperty.all(white),
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

  // Custom text styles with Cairo font and all weights
  static TextStyle cairoTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = oxfordBlue,
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
  static TextStyle cairoLight({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w300, color: color, height: height);
  }

  static TextStyle cairoRegular({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w400, color: color, height: height);
  }

  static TextStyle cairoMedium({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: color, height: height);
  }

  static TextStyle cairoSemiBold({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: color, height: height);
  }

  static TextStyle cairoBold({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: color, height: height);
  }

  static TextStyle cairoExtraBold({double fontSize = 16, Color color = oxfordBlue, double? height}) {
    return cairoTextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, color: color, height: height);
  }

  static TextStyle cairoBlack({double fontSize = 16, Color color = oxfordBlue, double? height}) {
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