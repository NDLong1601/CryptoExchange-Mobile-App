import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Storage service implementation
  /// constructor singleton pattern
  StorageService._internal();

  /// Singleton instance
  static final StorageService _instance = StorageService._internal();

  /// getter instance
  static StorageService get instance => _instance;

  /// define key
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyThemeMode = 'theme_mode';

  late SharedPreferences _prefs;

  /// Stream Controllers -> handle realtime data changes from favorite coins

  /// Functions
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Đánh dấu đã hoàn thành onboarding
  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(_keyOnboardingCompleted, value);
    debugPrint('Onboarding completed set to $value');
  }

  /// Kiểm tra đã hoàn thành onboarding hay chưa
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  /// set theme mode
  Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool(_keyThemeMode, isDarkMode);
  }

  /// get theme mode
  Future<bool> getThemeMode() async {
    return _prefs.getBool(_keyThemeMode) ?? false;
  }

  /// save list favorite coins

  /// get list favorite coins
}
