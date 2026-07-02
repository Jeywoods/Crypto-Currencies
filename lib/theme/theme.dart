import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF31312E),
  dividerColor: Colors.white10,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2C2B2A),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withValues(alpha: 0.6),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),

  cardColor: const Color(0xFF2C2C2C),
  primaryColor: const Color(0xFF4CAF50),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF4CAF50),
    secondary: Color(0xFFFF6B6B),
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);