import 'package:flutter/material.dart';
import 'package:super_mall/core/theme/app_color/app_color_dark.dart';

ThemeData getThemeDataDark() {
  return ThemeData(
    primaryColor: AppColorDark.primary,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColorDark.primary),
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
  );
}
