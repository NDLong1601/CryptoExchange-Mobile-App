import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinProvider extends ChangeNotifier {
  // Demo provider implementation
  final CoinRepository _coinRepository = CoinRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Coin? _coin;
  Coin? get coin => _coin;

  /// List<Coin> _coins = [];

  Future<void> subscribeToTicker(String symbol) async {
    await _coinRepository.subscribeToCoinTicker(symbol);

    /// Listen to coin stream
    _coinRepository.coinStream.listen(
      (coinData) {
        _coin = coinData;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }
}
