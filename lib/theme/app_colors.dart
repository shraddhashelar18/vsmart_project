import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4A90E2);   // ✔ USED BY student/teacher
  static const Color primaryColor = Color(0xFF4A90E2); // ✔ support older code
  static const Color bgColor = Color(0xFFF4F6FA);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF4A90E2),
      Color(0xFF6BB4FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
