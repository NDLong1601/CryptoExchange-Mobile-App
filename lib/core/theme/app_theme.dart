import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Dark Mode Theme config
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.black,
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.black,
      iconTheme: IconThemeData(color: AppColor.bg),
    ),

    /// color
    /// text style
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColor.bg),
      displayMedium: TextStyle(color: AppColor.bggreen),
    ),
  );

  /// Light Mode Theme config
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.white,
      iconTheme: IconThemeData(color: AppColor.bg),
    ),
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
  );
}
