import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF2DD881);
  static const Color darkGreen = Color(0xFF1DB863);
  static const Color lightGreen = Color(0xFF3FE991);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color textGray = Color(0xFF757575);
  static const Color darkText = Color(0xFF212121);
  
  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3FE991),
      Color(0xFF2DD881),
    ],
  );
}
