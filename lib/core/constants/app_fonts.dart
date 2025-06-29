// lib/core/theme/app_fonts.dart
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppFonts {
  // أحجام الخطوط
  static const double appName = 59.0;
  static const double h1 = 32.0;
  static const double h2 = 24.0;
  static const double h3 = 20.0;
  static const double bodyLarge = 18.0;
  static const double bodyMedium = 16.0;
  static const double bodySmall = 14.0;
  static const double caption = 12.0;

  // أوزان الخطوط
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // عائلة الخطوط (يمكن تغييرها حسب الخط المستخدم)
  static const String fontFamily = 'Roboto';

  // أنماط نصية جاهزة للاستخدام

  static TextStyle get splashAppNAme => TextStyle(
    fontFamily: fontFamily,
    fontSize: appName,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.splashColorElements,
  );

  static TextStyle get titlePageName => TextStyle(
    fontFamily: fontFamily,
    fontSize: h2,
    fontWeight: medium,
    height: 1.2,
    color: AppColors.textDark,
  );

  static TextStyle get noteStyle => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodySmall,
    fontWeight: regular,
    height: 1.2,
    color: AppColors.noteColor,
  );

  static TextStyle get bodyLargeStyle => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyMedium,
    fontWeight: regular,
    height: 1.2,
    color: AppColors.textDark,
  );

  static TextStyle get bodyLargeForgotStyle => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyLarge,
    fontWeight: regular,
    height: 1.2,
    color: AppColors.accentBlue,
  );

  static TextStyle get captionRegularStyle => TextStyle(
    fontFamily: fontFamily,
    fontSize: caption,
    fontWeight: regular,
    height: 1.2,
    color: AppColors.textDark,
  );
}
