import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:cryptoexchange_mobile_app/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteRepository favoriteRepository;
  final CoinRepository coinRepository;

  FavoriteProvider({
    required this.favoriteRepository,
    required this.coinRepository,
  }) {
    init();
  }

  /// state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<Coin> _favoriteCoins = [];
  List<Coin> get favoriteCoins => _favoriteCoins;

  List<String> _favoriteSymbolsFromLocalStorage = [];

  /// Functions
  Future<void> init() async {
    try {
      _isLoading = true;
      notifyListeners();

      /// get favorite tokens from storage
      _favoriteSymbolsFromLocalStorage = favoriteRepository.getFavoriteTokens();

      /// Listen to local storage changes
      favoriteRepository.favoriteTokensStream.listen((favoriteCoins) {
        _favoriteSymbolsFromLocalStorage = favoriteCoins;

        _updateFavoriteCoins(coinRepository.currentCoins);
      });

      /// get favorite coins from coin repository
      /// listen to coin stream to get realtime updates
      coinRepository.coinStream.listen((allCoins) {
        _updateFavoriteCoins(allCoins);
      });
    } catch (e) {
      _errorMessage = 'Failed to load favorite coins: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _updateFavoriteCoins(List<Coin> allCoins) {
    _favoriteCoins = allCoins
        .where(
          (coin) => _favoriteSymbolsFromLocalStorage.contains(
            coin.symbol.toLowerCase(),
          ),
        )
        .toList();
    notifyListeners();
  }

  /// toggle favorite token
  Future<void> toggleFavoriteToken(String symbol) async {
    try {
      _isLoading = true;
      notifyListeners();

      await favoriteRepository.toggleFavoriteToken(symbol);
    } catch (e) {
      _errorMessage = 'Failed to toggle favorite token: $e';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
