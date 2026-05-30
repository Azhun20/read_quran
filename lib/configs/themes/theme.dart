import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_quran/shared/styles/color_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorStyle.primary500,
        primary: ColorStyle.primary500,
        secondary: ColorStyle.secondary500,
      ),
      scaffoldBackgroundColor: ColorStyle.neutral0,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorStyle.white,
        foregroundColor: ColorStyle.neutral900,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle.primary500,
          foregroundColor: ColorStyle.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: ColorStyle.neutral0,
      ),
    );
  }
}
