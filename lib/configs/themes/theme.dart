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
        primary: ColorStyle.primary900,
        secondary: ColorStyle.secondary500,
        surface: ColorStyle.neutral0,
        onPrimary: ColorStyle.secondary500,
        onSecondary: ColorStyle.primary900,
      ),
      scaffoldBackgroundColor: const Color(0XFFfff8ee),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: ColorStyle.primary900,
        foregroundColor: ColorStyle.secondary500,
        iconTheme: IconThemeData(color: ColorStyle.secondary500),
        titleTextStyle: TextStyle(
          color: ColorStyle.secondary500,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle.primary900,
          foregroundColor: ColorStyle.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorStyle.secondary500,
        foregroundColor: ColorStyle.primary900,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorStyle.primary900,
        selectedItemColor: ColorStyle.secondary500,
        unselectedItemColor: ColorStyle.primary300,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: ColorStyle.neutral0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ColorStyle.neutral40),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorStyle.neutral40),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorStyle.neutral40),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorStyle.primary900, width: 2),
        ),
        filled: true,
        fillColor: ColorStyle.neutral0,
      ),
      iconTheme: const IconThemeData(color: ColorStyle.primary900),
    );
  }
}
