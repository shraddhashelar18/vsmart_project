import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF4A90E2); // Blue
  static const accentColor = Color(0xFF50E3C2); // Mint
  static const bgColor = Color(0xFFF5F7FA);
  static const cardColor = Colors.white;
  static const textColor = Colors.black87;

  // ✅ ADD THIS
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      accentColor,
    ],
  );
}
