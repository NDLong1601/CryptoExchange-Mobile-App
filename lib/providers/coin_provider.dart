import 'package:cryptoexchange_mobile_app/core/const/app_data.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:cryptoexchange_mobile_app/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

class CoinProvider extends ChangeNotifier {
  CoinProvider({
    required this.coinRepository,
    required this.favoriteRepository,
  }) {
    init();
  }

  final CoinRepository coinRepository;
  final FavoriteRepository favoriteRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

  String _selectedSymbol = 'btcusdt';
  String get selectedSymbol => _selectedSymbol;

  bool get isFavorite =>
      favoriteRepository.getFavoriteTokens().contains(_selectedSymbol);

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    try {
      await coinRepository.subscribeToCoins(AppData.trackedSymbols);
      debugPrint('Started listening to coin updates');
      coinRepository.coinStream.listen(
        (coinData) {
          _coins = coinData;
          notifyListeners();
        },
        onError: (err) {
          _errorMessage = err.toString();
          debugPrint('Error in coin stream: $_errorMessage');
          notifyListeners();
        },
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      debugPrint('Error starting coin listener: $_errorMessage');
      notifyListeners();
    }
  }

  /// function to get default coin
  /// default is BTCUSDT (symbol: btcusdt)
  Coin defaultCoin() {
    if (_coins.isEmpty) {
      debugPrint('No coins available, returning a placeholder coin');
    }
    return _coins.firstWhere(
      (coin) => coin.symbol.toLowerCase() == 'btcusdt',
      orElse: () => Coin(
        symbol: 'btcusdt',
        priceChangePercent: '0',
        currentPrice: '0',
        volume: '0',
      ),
    );
  }

  // /// function to select a coin
  // void selectCoin(Coin coin) {
  //   _coinSelected = coin;
  //   notifyListeners();
  // }

  /// change selected coin by symbol
  void selectCoinBySymbol(String symbol) {
    _selectedSymbol = symbol.toLowerCase();
    notifyListeners();
  }

  void stopListening() {
    coinRepository.disconnect();
    debugPrint('Stopped listening to coin updates');
  }
}
