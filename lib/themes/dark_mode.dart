import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: const Color(0xFF1A1F1C),    // Dark green-grey background
    primary: const Color(0xFF4CAF8D),     // Same green as light theme
    secondary: const Color(0xFF243830),   // Darker green-grey
    inversePrimary: const Color(0xFFB8E5D0), // Light mint
    background: const Color(0xFF121715),   // Darker background
    onSurface: const Color(0xFFE8F0EB),    // Light mint text
    onPrimary: const Color(0xFFFFFFFF),    // White text on primary
    onSecondary: const Color(0xFFE8F0EB),  // Light text on secondary
    tertiary: const Color(0xFF3D8B6F),     // Darker accent green
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFE8F0EB)),
    bodyMedium: TextStyle(color: Color(0xFFE8F0EB)),
  ),
);
