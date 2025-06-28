import 'package:flutter/material.dart';
import 'package:trading_sample_app/app/constants/custom_colors.dart';

class AppTextTheme {
  static TextTheme getThemeText() => TextTheme(
    // Bold
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.textPrimary,
    ),
    // Bold
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: CustomColors.textPrimary,
    ),
    // Regular
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: CustomColors.textPrimary,
    ),
    // Regular
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: CustomColors.textPrimary,
    ),
    // Bold
    labelLarge: TextStyle(
      fontSize: 16,
      color: CustomColors.textPrimary,
      fontWeight: FontWeight.bold,
    ),
  );
}
