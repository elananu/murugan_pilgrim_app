import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF1A0A2E);
  static const Color primaryMid = Color(0xFF2D0A4E);
  static const Color primaryLight = Color(0xFF4A1060);
  static const Color gold = Color(0xFFFFD700);
  static const Color orange = Color(0xFFFF9800);
  static const Color white70 = Color(0xB3FFFFFF);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryDark,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
