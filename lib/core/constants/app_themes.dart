// import 'package:flutter/material.dart';
// import 'package:aqarak/core/constants/app_colors.dart';
// import 'package:aqarak/core/constants/app_sizes.dart';

// class AppTheme {
//   // أحجام الخطوط
//   static const double appName = 59.0;
//   static const double h1 = 32.0;
//   static const double h2 = 24.0;
//   static const double h3 = 20.0;
//   static const double bodyLarge = 18.0;
//   static const double bodyMedium = 16.0;
//   static const double bodySmall = 14.0;
//   static const double caption = 12.0;

//   // أوزان الخطوط
//   static const FontWeight light = FontWeight.w300;
//   static const FontWeight regular = FontWeight.w400;
//   static const FontWeight medium = FontWeight.w500;
//   static const FontWeight semiBold = FontWeight.w600;
//   static const FontWeight bold = FontWeight.w700;

//   // عائلة الخطوط
//   static const String fontFamily = 'Roboto';

//   // أنماط نصية أساسية
//   static TextStyle _baseTextStyle({
//     double fontSize = bodyMedium,
//     FontWeight fontWeight = regular,
//     Color color = AppColors.textLight,
//     double height = 1.5,
//   }) {
//     return TextStyle(
//       fontFamily: fontFamily,
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//       height: height,
//     );
//   }

//   // أنماط نصية جاهزة للاستخدام
//   static final TextTheme lightTextTheme = TextTheme(
//     displayLarge: _baseTextStyle(
//       fontSize: AppSizes.appNameFontSize,
//       fontWeight: bold,
//       color: AppColors.textLight,
//     ),
//     headlineLarge: _baseTextStyle(fontSize: h1, fontWeight: bold, height: 1.2),
//     headlineMedium: _baseTextStyle(
//       fontSize: h2,
//       fontWeight: semiBold,
//       height: 1.3,
//     ),
//     headlineSmall: _baseTextStyle(
//       fontSize: h3,
//       fontWeight: medium,
//       height: 1.3,
//     ),
//     bodyLarge: _baseTextStyle(fontSize: bodyLarge, fontWeight: regular),
//     bodyMedium: _baseTextStyle(fontSize: bodyMedium, fontWeight: regular),
//     bodySmall: _baseTextStyle(fontSize: bodySmall, fontWeight: regular),
//     labelSmall: _baseTextStyle(fontSize: caption, fontWeight: light),
//   );

//   static final TextTheme darkTextTheme = TextTheme(
//     displayLarge: _baseTextStyle(
//       fontSize: AppSizes.appNameFontSize,
//       fontWeight: bold,
//       color: AppColors.textDark,
//     ),
//     headlineLarge: _baseTextStyle(
//       fontSize: h1,
//       fontWeight: bold,
//       color: AppColors.textDark,
//       height: 1.2,
//     ),
//     // ... نفس الأنماط مع تعديل الألوان للوضع الداكن
//   );

//   // الثيمات
//   static final ThemeData lightTheme = ThemeData(
//     primaryColor: AppColors.primaryGreen,
//     brightness: Brightness.light,
//     fontFamily: fontFamily,
//     textTheme: lightTextTheme,
//     // إضافة باقي خصائص الثيم
//   );

//   static final ThemeData darkTheme = ThemeData(
//     primaryColor: AppColors.primaryGreen,
//     brightness: Brightness.dark,
//     fontFamily: fontFamily,
//     textTheme: darkTextTheme,
//     // إضافة باقي خصائص الثيم
//   );
// }
