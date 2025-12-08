// lib/src/theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF3B60FF); // deep blue
  static const surface = Color(0xFFF7F9FF); // soft background
  static const accent = Color(0xFF00C2A8); // teal accent
  static const muted = Color(0xFF6B7280); // grey for subtitles
  static const danger = Color(0xFFF44336);
}

final ThemeData AppTheme = ThemeData(
  useMaterial3: false,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.surface,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
  ).copyWith(secondary: AppColors.accent),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    subtitle1: TextStyle(fontSize: 14, color: AppColors.muted),
    bodyText1: TextStyle(fontSize: 15),
    button: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
);
