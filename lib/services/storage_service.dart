import 'dart:async';

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
  static const String _keyFavoriteTokens = 'favorite_tokens';

  late SharedPreferences _prefs;

  /// Stream Controllers -> handle realtime data changes from favorite coins
  StreamController<List<String>> favoriteTokensStreamController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get favoriteTokensStream =>
      favoriteTokensStreamController.stream;

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

  /// toggle list favorite coins
  /// Logic: check if symbol exists in list -> remove it, else add it
  /// Example: ['btcusdt', 'ETHUSDT']
  Future<void> toggleFavoriteToken(String symbol) async {
    /// convert symbol to lowercase
    final normalizedSymbol = symbol.toLowerCase();

    List<String> currentFavorites = getFavoriteTokens();

    if (currentFavorites.contains(normalizedSymbol)) {
      currentFavorites.remove(normalizedSymbol);
    } else {
      currentFavorites.insert(0, normalizedSymbol);
    }

    /// save new list to local storage
    await _prefs.setStringList(_keyFavoriteTokens, currentFavorites);

    favoriteTokensStreamController.add(currentFavorites);
  }

  /// get list favorite coins
  List<String> getFavoriteTokens() {
    List<String> currentFavorites =
        _prefs.getStringList(_keyFavoriteTokens) ?? [];

    /// lowercase all symbols
    // currentFavorites = currentFavorites.map((e) => e.toLowerCase()).toList();
    for (var i = 0; i < currentFavorites.length; i++) {
      currentFavorites[i] = currentFavorites[i].toLowerCase();
    }
    return currentFavorites;
  }
}
