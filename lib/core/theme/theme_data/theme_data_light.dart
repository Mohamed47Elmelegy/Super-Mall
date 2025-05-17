import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';

ThemeData getThemeDataLight() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFFAFAFA), // الخلفية الجديدة

    primaryColor: AppColorLight.primary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColorLight.button),
        foregroundColor: WidgetStateProperty.all(AppColorLight.textButton),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0.w),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorLight.grey1,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: EdgeInsets.all(12),

      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(4.0.w),
      //   borderSide: BorderSide(
      //     color: AppColorLight.primary,
      //   ),
      // ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(4.0.w),
      //   borderSide: BorderSide(
      //     color: AppColorLight.primary,
      //   ),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(4.0.w),
      //   borderSide: BorderSide(
      //     color: AppColorLight.primary,
      //   ),
      // ),
      labelStyle: TextStyle(
        color: AppColorLight.primary,
      ),
    ),
    fontFamily: 'CircularStd',
  );
}
