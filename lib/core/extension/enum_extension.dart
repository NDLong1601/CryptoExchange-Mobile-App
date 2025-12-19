library;

import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';

/// Enum extension
extension AppThemeModeExtension on AppThemeMode {
  // Get name of enum
  String get name {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }
}
