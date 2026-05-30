import 'package:flutter/material.dart';
import 'package:read_quran/shared/styles/app_font_style.dart';
import 'package:read_quran/shared/styles/color_style.dart';

/// ThemeContextExtension
///
/// Memperluas [BuildContext] agar bisa langsung
/// akses style font seperti `context.body3Bold`, `context.heading1Light`, dll.
extension ThemeContextExtension on BuildContext {
  // === Base Theme Accessors ===
  // === Base Theme Accessors ===
  InputDecorationThemeData get inputDecorationTheme =>
      Theme.of(this).inputDecorationTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // === Adaptive Colors ===

  // Primary
  Color get primary50 => isDark ? ColorStyle.primary900 : ColorStyle.primary50;
  Color get primary100 =>
      isDark ? ColorStyle.primary800 : ColorStyle.primary100;
  Color get primary200 =>
      isDark ? ColorStyle.primary700 : ColorStyle.primary200;
  Color get primary300 =>
      isDark ? ColorStyle.primary600 : ColorStyle.primary300;
  Color get primary400 =>
      isDark ? ColorStyle.primary500 : ColorStyle.primary400;
  Color get primary500 =>
      isDark ? ColorStyle.primary400 : ColorStyle.primary500;
  Color get primary600 =>
      isDark ? ColorStyle.primary300 : ColorStyle.primary600;
  Color get primary700 =>
      isDark ? ColorStyle.primary200 : ColorStyle.primary700;
  Color get primary800 =>
      isDark ? ColorStyle.primary100 : ColorStyle.primary800;
  Color get primary900 => isDark ? ColorStyle.primary50 : ColorStyle.primary900;

  // Secondary
  Color get secondary50 =>
      isDark ? ColorStyle.secondary900 : ColorStyle.secondary50;
  Color get secondary100 =>
      isDark ? ColorStyle.secondary800 : ColorStyle.secondary100;
  Color get secondary200 =>
      isDark ? ColorStyle.secondary700 : ColorStyle.secondary200;
  Color get secondary300 =>
      isDark ? ColorStyle.secondary600 : ColorStyle.secondary300;
  Color get secondary400 =>
      isDark ? ColorStyle.secondary500 : ColorStyle.secondary400;
  Color get secondary500 =>
      isDark ? ColorStyle.secondary400 : ColorStyle.secondary500;
  Color get secondary600 =>
      isDark ? ColorStyle.secondary300 : ColorStyle.secondary600;
  Color get secondary700 =>
      isDark ? ColorStyle.secondary200 : ColorStyle.secondary700;
  Color get secondary800 =>
      isDark ? ColorStyle.secondary100 : ColorStyle.secondary800;
  Color get secondary900 =>
      isDark ? ColorStyle.secondary50 : ColorStyle.secondary900;

  // Tertiary
  Color get tertiary50 =>
      isDark ? ColorStyle.tertiary900 : ColorStyle.tertiary50;
  Color get tertiary100 =>
      isDark ? ColorStyle.tertiary800 : ColorStyle.tertiary100;
  Color get tertiary200 =>
      isDark ? ColorStyle.tertiary700 : ColorStyle.tertiary200;
  Color get tertiary300 =>
      isDark ? ColorStyle.tertiary600 : ColorStyle.tertiary300;
  Color get tertiary400 =>
      isDark ? ColorStyle.tertiary500 : ColorStyle.tertiary400;
  Color get tertiary500 =>
      isDark ? ColorStyle.tertiary400 : ColorStyle.tertiary500;
  Color get tertiary600 =>
      isDark ? ColorStyle.tertiary300 : ColorStyle.tertiary600;
  Color get tertiary700 =>
      isDark ? ColorStyle.tertiary200 : ColorStyle.tertiary700;
  Color get tertiary800 =>
      isDark ? ColorStyle.tertiary100 : ColorStyle.tertiary800;
  Color get tertiary900 =>
      isDark ? ColorStyle.tertiary50 : ColorStyle.tertiary900;

  // Success
  Color get success50 => isDark ? ColorStyle.success900 : ColorStyle.success50;
  Color get success100 =>
      isDark ? ColorStyle.success800 : ColorStyle.success100;
  Color get success200 =>
      isDark ? ColorStyle.success700 : ColorStyle.success200;
  Color get success300 =>
      isDark ? ColorStyle.success600 : ColorStyle.success300;
  Color get success400 =>
      isDark ? ColorStyle.success500 : ColorStyle.success400;
  Color get success500 =>
      isDark ? ColorStyle.success400 : ColorStyle.success500;
  Color get success600 =>
      isDark ? ColorStyle.success300 : ColorStyle.success600;
  Color get success700 =>
      isDark ? ColorStyle.success200 : ColorStyle.success700;
  Color get success800 =>
      isDark ? ColorStyle.success100 : ColorStyle.success800;
  Color get success900 => isDark ? ColorStyle.success50 : ColorStyle.success900;

  // Danger
  Color get danger50 => isDark ? ColorStyle.danger900 : ColorStyle.danger50;
  Color get danger100 => isDark ? ColorStyle.danger800 : ColorStyle.danger100;
  Color get danger200 => isDark ? ColorStyle.danger700 : ColorStyle.danger200;
  Color get danger300 => isDark ? ColorStyle.danger600 : ColorStyle.danger300;
  Color get danger400 => isDark ? ColorStyle.danger500 : ColorStyle.danger400;
  Color get danger500 => isDark ? ColorStyle.danger400 : ColorStyle.danger500;
  Color get danger600 => isDark ? ColorStyle.danger300 : ColorStyle.danger600;
  Color get danger700 => isDark ? ColorStyle.danger200 : ColorStyle.danger700;
  Color get danger800 => isDark ? ColorStyle.danger100 : ColorStyle.danger800;
  Color get danger900 => isDark ? ColorStyle.danger50 : ColorStyle.danger900;

  // Warning
  Color get warning50 => isDark ? ColorStyle.warning900 : ColorStyle.warning50;
  Color get warning100 =>
      isDark ? ColorStyle.warning800 : ColorStyle.warning100;
  Color get warning200 =>
      isDark ? ColorStyle.warning700 : ColorStyle.warning200;
  Color get warning300 =>
      isDark ? ColorStyle.warning600 : ColorStyle.warning300;
  Color get warning400 =>
      isDark ? ColorStyle.warning500 : ColorStyle.warning400;
  Color get warning500 =>
      isDark ? ColorStyle.warning400 : ColorStyle.warning500;
  Color get warning600 =>
      isDark ? ColorStyle.warning300 : ColorStyle.warning600;
  Color get warning700 =>
      isDark ? ColorStyle.warning200 : ColorStyle.warning700;
  Color get warning800 =>
      isDark ? ColorStyle.warning100 : ColorStyle.warning800;
  Color get warning900 => isDark ? ColorStyle.warning50 : ColorStyle.warning900;

  // Info
  Color get info50 => isDark ? ColorStyle.info900 : ColorStyle.info50;
  Color get info100 => isDark ? ColorStyle.info800 : ColorStyle.info100;
  Color get info200 => isDark ? ColorStyle.info700 : ColorStyle.info200;
  Color get info300 => isDark ? ColorStyle.info600 : ColorStyle.info300;
  Color get info400 => isDark ? ColorStyle.info500 : ColorStyle.info400;
  Color get info500 => isDark ? ColorStyle.info400 : ColorStyle.info500;
  Color get info600 => isDark ? ColorStyle.info300 : ColorStyle.info600;
  Color get info700 => isDark ? ColorStyle.info200 : ColorStyle.info700;
  Color get info800 => isDark ? ColorStyle.info100 : ColorStyle.info800;
  Color get info900 => isDark ? ColorStyle.info50 : ColorStyle.info900;

  // Neutral
  Color get neutral0 => isDark ? ColorStyle.neutral900 : ColorStyle.neutral0;
  Color get neutral10 => isDark ? ColorStyle.neutral800 : ColorStyle.neutral10;
  Color get neutral20 => isDark ? ColorStyle.neutral700 : ColorStyle.neutral20;
  Color get neutral30 => isDark ? ColorStyle.neutral600 : ColorStyle.neutral30;
  Color get neutral40 => isDark ? ColorStyle.neutral500 : ColorStyle.neutral40;
  Color get neutral50 => isDark ? ColorStyle.neutral400 : ColorStyle.neutral50;
  Color get neutral60 => isDark ? ColorStyle.neutral300 : ColorStyle.neutral60;
  Color get neutral70 => isDark ? ColorStyle.neutral200 : ColorStyle.neutral70;
  Color get neutral80 => isDark ? ColorStyle.neutral100 : ColorStyle.neutral80;
  Color get neutral90 => isDark ? ColorStyle.neutral90 : ColorStyle.neutral90;
  Color get neutral100 => isDark ? ColorStyle.neutral80 : ColorStyle.neutral100;
  Color get neutral200 => isDark ? ColorStyle.neutral70 : ColorStyle.neutral200;
  Color get neutral300 => isDark ? ColorStyle.neutral60 : ColorStyle.neutral300;
  Color get neutral400 => isDark ? ColorStyle.neutral50 : ColorStyle.neutral400;
  Color get neutral500 => isDark ? ColorStyle.neutral40 : ColorStyle.neutral500;
  Color get neutral600 => isDark ? ColorStyle.neutral30 : ColorStyle.neutral600;
  Color get neutral700 => isDark ? ColorStyle.neutral20 : ColorStyle.neutral700;
  Color get neutral800 => isDark ? ColorStyle.neutral10 : ColorStyle.neutral800;
  Color get neutral900 => isDark ? ColorStyle.neutral0 : ColorStyle.neutral900;

  // Category
  Color get categoryFill => const Color(0xffFFECEA);
  Color get categoryStroke => const Color(0xffFFBCB4);
  Color get categoryText => const Color(0xffFFBCB4);

  // === Font Styles (AppFontStyle) ===

  // Light
  TextStyle get display2Light => AppFontStyle.display2Light;
  TextStyle get display1Light => AppFontStyle.display1Light;
  TextStyle get heading2Light => AppFontStyle.heading2Light;
  TextStyle get heading1Light => AppFontStyle.heading1Light;
  TextStyle get body3Light => AppFontStyle.body3Light;
  TextStyle get body2Light => AppFontStyle.body2Light;
  TextStyle get body1Light => AppFontStyle.body1Light;
  TextStyle get caption2Light => AppFontStyle.caption2Light;
  TextStyle get caption1Light => AppFontStyle.caption1Light;

  // Regular
  TextStyle get display2Regular => AppFontStyle.display2Regular;
  TextStyle get display1Regular => AppFontStyle.display1Regular;
  TextStyle get heading2Regular => AppFontStyle.heading2Regular;
  TextStyle get heading1Regular => AppFontStyle.heading1Regular;
  TextStyle get body3Regular => AppFontStyle.body3Regular;
  TextStyle get body2Regular => AppFontStyle.body2Regular;
  TextStyle get body1Regular => AppFontStyle.body1Regular;
  TextStyle get caption2Regular => AppFontStyle.caption2Regular;
  TextStyle get caption1Regular => AppFontStyle.caption1Regular;

  // Medium
  TextStyle get display2Medium => AppFontStyle.display2Medium;
  TextStyle get display1Medium => AppFontStyle.display1Medium;
  TextStyle get heading2Medium => AppFontStyle.heading2Medium;
  TextStyle get heading1Medium => AppFontStyle.heading1Medium;
  TextStyle get body3Medium => AppFontStyle.body3Medium;
  TextStyle get body2Medium => AppFontStyle.body2Medium;
  TextStyle get body1Medium => AppFontStyle.body1Medium;
  TextStyle get caption2Medium => AppFontStyle.caption2Medium;
  TextStyle get caption1Medium => AppFontStyle.caption1Medium;

  // SemiBold
  TextStyle get display2SemiBold => AppFontStyle.display2SemiBold;
  TextStyle get display1SemiBold => AppFontStyle.display1SemiBold;
  TextStyle get heading2SemiBold => AppFontStyle.heading2SemiBold;
  TextStyle get heading1SemiBold => AppFontStyle.heading1SemiBold;
  TextStyle get body3SemiBold => AppFontStyle.body3SemiBold;
  TextStyle get body2SemiBold => AppFontStyle.body2SemiBold;
  TextStyle get body1SemiBold => AppFontStyle.body1SemiBold;
  TextStyle get caption2SemiBold => AppFontStyle.caption2SemiBold;
  TextStyle get caption1SemiBold => AppFontStyle.caption1SemiBold;

  // Bold
  TextStyle get display2Bold => AppFontStyle.display2Bold;
  TextStyle get display1Bold => AppFontStyle.display1Bold;
  TextStyle get heading2Bold => AppFontStyle.heading2Bold;
  TextStyle get heading1Bold => AppFontStyle.heading1Bold;
  TextStyle get body3Bold => AppFontStyle.body3Bold;
  TextStyle get body2Bold => AppFontStyle.body2Bold;
  TextStyle get body1Bold => AppFontStyle.body1Bold;
  TextStyle get caption2Bold => AppFontStyle.caption2Bold;
  TextStyle get caption1Bold => AppFontStyle.caption1Bold;

  TextStyle get heading1BoldRajdhani => AppFontStyle.heading1BoldRajdhani;
}
