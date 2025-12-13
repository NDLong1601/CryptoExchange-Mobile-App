import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  // Screen height
  double get sh => MediaQuery.of(this).size.height;

  // Screen width
  double get sw => MediaQuery.of(this).size.width;
}
