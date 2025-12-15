import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _init();
  }

  Future<void> _init() async {
    _isDarkMode = await StorageService.instance.getThemeMode();
    notifyListeners();
  }

  /// Toggle theme
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await StorageService.instance.setThemeMode(_isDarkMode);
  }

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
