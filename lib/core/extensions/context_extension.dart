import 'package:flutter/material.dart';

/// Context Extension
extension ContextExtension on BuildContext {
  /// Screen Width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen Height
  double get screenHeight => MediaQuery.of(this).size.height;
}
