import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinProvider extends ChangeNotifier {
  final CoinRepository coinRepository = CoinRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final Map<String, Coin> _coinsMap = {};
  List<Coin> get coins => _coinsMap.values.toList();

  Stream<Coin> get coinStream => coinRepository.coinStream;

  final List<String> trackedSymbols = [
    'btcusdt',
    'ethusdt',
    'bnbusdt',
    'solusdt',
    'adausdt',
    'xrpusdt',
    'dotusdt',
    'maticusdt',
    'dogeusdt',
    'avaxusdt',
    'linkusdt',
    'ltcusdt',
    'atomusdt',
    'nearusdt',
    'filusdt',
    'uniusdt',
    'trxusdt',
    'xlmusdt',
    'apeusdt',
    'egldusdt',
  ];

  Future<void> startListening() async {
    _isLoading = true;
    notifyListeners();
    try {
      await coinRepository.subscribeToCoins(trackedSymbols);
      debugPrint('Started listening to coin updates');
      coinRepository.coinStream.listen(
        (coinData) {
          // Update map
          final symbol = coinData.symbol.toLowerCase();
          _coinsMap[symbol] = coinData;
          debugPrint('Updated coin data: $symbol -> ${coinData.price}');
          debugPrint('Total coins tracked: ${_coinsMap.length}');
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
