import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StorageService {
  // Storage service implementation
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  static const String _keyOnboardingCompleted = 'onboarding_completed';

  /// Đánh dấu đã hoàn thành onboarding
  Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingCompleted, value);
    debugPrint('Onboarding completed set to $value');
  }

  /// Kiểm tra đã hoàn thành onboarding hay chưa
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }
}
