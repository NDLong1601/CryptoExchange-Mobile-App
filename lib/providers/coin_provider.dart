import 'package:cryptoexchange_mobile_app/core/const/app_data.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinProvider extends ChangeNotifier {
  CoinProvider() {
    init();
  }

  final CoinRepository coinRepository = CoinRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

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

  void stopListening() {
    coinRepository.disconnect();
    debugPrint('Stopped listening to coin updates');
  }
}
