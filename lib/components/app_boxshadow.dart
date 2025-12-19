import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:flutter/material.dart';

class AppBoxShadow {
  static BoxShadow custom({
    double spreadRadius = 0,
    double blurRadius = 0,
    double x = 0,
    double y = 4,
    Color color = AppColor.black,
    double opacity = 0.25,
  }) {
    return BoxShadow(
      color: color.withValues(alpha: opacity),
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      offset: Offset(x, y),
    );
  }
}
