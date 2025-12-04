import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Storage service implementation
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();

  /// Singleton instance
  factory StorageService() => _instance;

  /// Alternative factory constructor
  static final StorageService instance = _instance;

  late SharedPreferences _sharedPreferences;

  /// Define keys for SharedPreferences
  static const String _keyOnboardingCompleted = 'onboarding_completed';

  /// Functions
  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Đánh dấu đã hoàn thành onboarding
  Future<void> setOnboardingCompleted(bool value) async {
    await _sharedPreferences.setBool(_keyOnboardingCompleted, value);
    debugPrint('Onboarding completed set to $value');
  }

  bool isOnboardingCompleted() {
    return _sharedPreferences.getBool(_keyOnboardingCompleted) ?? false;
  }
}
