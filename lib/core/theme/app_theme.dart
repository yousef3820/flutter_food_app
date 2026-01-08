import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Roboto",
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: MainColors.mainColor,
      secondary: MainColors.mainColor,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    primaryColor: MainColors.mainColor,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      surfaceTintColor: Colors.transparent,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
      bodySmall: TextStyle(color: Color(0xff6A6A6A), fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.mainColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        disabledBackgroundColor: const Color.fromARGB(255, 216, 213, 213), // Disabled background
        disabledForegroundColor: Colors.grey.shade600, // Disabled text color
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MainColors.mainColor,
        side: BorderSide(color: MainColors.mainColor, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(color: MainColors.mainColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: MainColors.mainColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: MainColors.mainColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: MainColors.mainColor, width: 2),
      ),
    ),
    iconTheme: const IconThemeData(color: MainColors.mainColor),
    dividerTheme: DividerThemeData(color: Colors.grey.shade300),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Roboto",
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
      primary: MainColors.secondaryColorDark,
      secondary: MainColors.secondaryColorDark,
      surface: const Color(0xFF1C1C1C),
      onSurface: Colors.white,
    ),

    primaryColor: MainColors.secondaryColorDark,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1C1C1C),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: const Color.fromARGB(255, 168, 164, 164)),
      ),
      surfaceTintColor: Colors.transparent,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
      bodySmall: TextStyle(color: Colors.white70, fontSize: 14),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MainColors.secondaryColorDark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
       disabledBackgroundColor: const Color.fromARGB(255, 216, 213, 213), // Disabled background
        disabledForegroundColor: Colors.grey.shade600, // Disabled text color
        
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: MainColors.secondaryColorDark, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      floatingLabelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
    ),
    iconTheme: const IconThemeData(color: MainColors.secondaryColorDark),
    dividerTheme: DividerThemeData(color: Colors.grey.shade800),
  );
}
