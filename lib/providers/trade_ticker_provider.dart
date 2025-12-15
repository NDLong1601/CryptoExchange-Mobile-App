import 'dart:async';

import 'package:cryptoexchange_mobile_app/repositories/trade_ticker_repository.dart';
import 'package:flutter/material.dart';

class TradeTickerProvider extends ChangeNotifier with WidgetsBindingObserver {
  final TradeTickerRepository tradeTickerRepository;

  TradeTickerProvider(this.tradeTickerRepository) {
    WidgetsBinding.instance.addObserver(this);
  }

  StreamSubscription? _sub;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _symbol = 'btcusdt';
  String get symbol => _symbol;

  String _price = '0';
  String get price => _price;

  String _percent = '0';
  String get percent => _percent;

  // init/ subscribe ticker
  Future<void> init(String symbol) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _symbol = symbol.toLowerCase();
      await _sub!.cancel();
      await tradeTickerRepository.subscribe(_symbol);

      _sub = tradeTickerRepository.tickerStream.listen(
        (data) {
          _price = data.lastPrice;
          _percent = data.priceChangePercent;
          _isLoading = false;
          notifyListeners();
        },
        onError: (e) {
          _isLoading = false;
          _errorMessage = e.toString();
          notifyListeners();
        },
      );
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      debugPrint('Error starting coin listener: $_errorMessage');
      notifyListeners();
    }
  }

  /// Change symbol (BTC → ETH ...)
  Future<void> changeSymbol(String symbol) async {
    await init(symbol);
  }

  /// Stop listening manually
  void stopListening() {
    _sub?.cancel();
    _sub = null;
    tradeTickerRepository.unsubscribe();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      stopListening();
    } else if (state == AppLifecycleState.resumed) {
      if (_sub == null) init(_symbol);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopListening();
    tradeTickerRepository.dispose();
    super.dispose();
  }
}
