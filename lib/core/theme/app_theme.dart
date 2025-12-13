import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColor.darkBackground,
    cardColor: AppColor.darkSuface,

    dividerColor: AppColor.white.withValues(alpha: 0.08),

    // Icon
    iconTheme: IconThemeData(color: AppColor.white),

    /// text style
    textTheme: TextTheme(
      titleLarge: TextStyle(color: AppColor.white),
      titleMedium: TextStyle(color: AppColor.white),

      labelMedium: TextStyle(color: AppColor.darkGreen),

      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),

    /// color style
    colorScheme: ColorScheme.dark(
      primary: AppColor.darkPrimary,
      secondary: AppColor.white,
      tertiary: AppColor.darkGreen,
      surface: AppColor.darkSuface,
      outline: Color(0xFFE5E7F0),
    ),

    /// Switch
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? const Color(0xFF4F7CFF)
            : Colors.white.withValues(alpha: 0.15),
      ),
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );

  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // Background
    scaffoldBackgroundColor: AppColor.bg,

    // Card/ Tile
    cardColor: AppColor.white,

    // Divder
    dividerColor: AppColor.grey.withValues(alpha: 0.08),

    // Icon
    iconTheme: IconThemeData(color: AppColor.grey),

    /// Text
    textTheme: TextTheme(
      titleLarge: TextStyle(color: AppColor.black),
      titleMedium: TextStyle(color: AppColor.black),
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),

    /// color style
    colorScheme: ColorScheme.light(
      primary: AppColor.primary,
      secondary: Colors.blueAccent,
      surface: AppColor.white,
      tertiary: AppColor.darkGreen,
      outline: Color(0xFFE5E7F0),
    ),

    /// Switch
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? const Color(0xFF4F7CFF)
            : Colors.grey.withValues(alpha: 0.15),
      ),
      thumbColor: WidgetStateProperty.all(Colors.grey),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
