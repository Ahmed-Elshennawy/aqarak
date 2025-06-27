// lib/core/theme/app_fonts.dart
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
    color: Colors.cyanAccent,
  );

  static TextStyle get headline1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: h1,
    fontWeight: bold,
    height: 1.2,
  );

  static TextStyle get headline2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: h2,
    fontWeight: semiBold,
    height: 1.3,
  );

  static TextStyle get headline3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: h3,
    fontWeight: medium,
    height: 1.3,
  );

  static TextStyle get bodyLg => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyLarge,
    fontWeight: regular,
    height: 1.5,
  );

  static TextStyle get bodyMd => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodyMedium,
    fontWeight: regular,
    height: 1.5,
  );

  static TextStyle get bodySm => TextStyle(
    fontFamily: fontFamily,
    fontSize: bodySmall,
    fontWeight: regular,
    height: 1.5,
  );

  static TextStyle get captionText => TextStyle(
    fontFamily: fontFamily,
    fontSize: caption,
    fontWeight: light,
    height: 1.5,
  );
}
