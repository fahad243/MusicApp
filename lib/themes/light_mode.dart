import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: const Color(0xFFF5F7F5),  // Light mint background
    primary: const Color(0xFF4CAF8D),   // Fresh green
    secondary: const Color(0xFFE8F0EB), // Softer mint
    inversePrimary: const Color(0xFF2C5B4A), // Dark green
    background: const Color(0xFFFFFFFF),  // Pure white
    onSurface: const Color(0xFF2C3E35),   // Dark green-grey for text
    onPrimary: const Color(0xFFFFFFFF),   // White text on primary
    onSecondary: const Color(0xFF2C3E35), // Dark text on secondary
    tertiary: const Color(0xFF7DCCA7),    // Light accent green
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF2C3E35)),
    bodyMedium: TextStyle(color: Color(0xFF2C3E35)),
  ),
);