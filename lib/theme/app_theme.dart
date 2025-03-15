import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFFFF6B6B);
  
  // Emotion Colors
  static const Color joyColor = Color(0xFFFFD93D);
  static const Color sadnessColor = Color(0xFF6C7A89);
  static const Color angerColor = Color(0xFFFF6B6B);
  static const Color fearColor = Color(0xFF8C4646);
  static const Color satisfactionColor = Color(0xFF87D37C);

  static const TextStyle headlineStyle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle captionStyle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Standard spacing
  static const double standardPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double cardRadius = 12.0;
  static const double buttonHeight = 48.0;
}