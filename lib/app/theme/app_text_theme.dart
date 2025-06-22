import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme getThemeText() => const TextTheme(
    // Bold
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    // Bold
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF03213E)),
    // Regular
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xffF8F9FA)),
    // Regular
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xff66788A)),
    // Bold
    labelLarge: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
  );
}
