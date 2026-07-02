import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF31312E),
    dividerColor: Colors.white10,
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2C2B2A),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w700
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      labelSmall: TextStyle(
        color: Colors.white.withValues(alpha: 0.2),
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),

    )
);