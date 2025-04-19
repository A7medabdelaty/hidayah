import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppTheme {
  // 🌓 الوضع الفاتح
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.greenColor,
        secondary: AppColors.backgroundColor,
        onSecondary: AppColors.greenColor,
        error: Colors.red,
        onError: Colors.white,
        surface: AppColors.foregroundColor,
        onSurface: AppColors.onForegroundColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 2,
        shadowColor: AppColors.black,
        foregroundColor: AppColors.white,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: textStyle(24.sp, FontWeight.bold, AppColors.black),
        displayMedium: textStyle(20.sp, FontWeight.bold, AppColors.black),
        displaySmall: textStyle(18.sp, FontWeight.w600, AppColors.black),
        headlineMedium: textStyle(16.sp, FontWeight.bold, AppColors.black),
        bodyLarge: textStyle(14.sp, FontWeight.normal, AppColors.black),
        bodyMedium: textStyle(12.sp, FontWeight.normal, AppColors.black),
      ),
      cardColor: AppColors.primaryColor,
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          textStyle: textStyle(16, FontWeight.bold, Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  // 🌙 الوضع الداكن
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDarkColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      fontFamily: 'Nunito',
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDarkColor,
        onPrimary: AppColors.darkGreenColor,
        secondary: AppColors.darkBackgroundColor,
        onSecondary: AppColors.darkGreenColor,
        error: Colors.red,
        onError: Colors.white,
        surface: AppColors.darkForegroundColor,
        onSurface: AppColors.darkOnForegroundColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: textStyle(24.sp, FontWeight.bold, Colors.white),
        displayMedium: textStyle(20.sp, FontWeight.bold, Colors.white),
        displaySmall: textStyle(18.sp, FontWeight.w600, Colors.white),
        headlineMedium: textStyle(16.sp, FontWeight.bold, Colors.white),
        bodyLarge: textStyle(14.sp, FontWeight.normal, Colors.white),
        bodyMedium: textStyle(12.sp, FontWeight.normal, Colors.grey),
      ),
      cardColor: Colors.grey[900],
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.darkBackgroundColor,
          backgroundColor: AppColors.primaryDarkColor,
          textStyle: textStyle(16, FontWeight.bold, Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  // 🎨 دالة لإنشاء TextStyle بسهولة
  static TextStyle textStyle(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
