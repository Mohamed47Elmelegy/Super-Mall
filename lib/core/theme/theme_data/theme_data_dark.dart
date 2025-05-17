import 'package:flutter/material.dart';
import 'package:super_mall/core/theme/app_color/app_color_dark.dart';

ThemeData getThemeDataDark() {
  return ThemeData(
    primaryColor: AppColorDark.primary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColorDark.button),
        foregroundColor: WidgetStateProperty.all(AppColorDark.textButton),
      ),
    ),
  );
}
