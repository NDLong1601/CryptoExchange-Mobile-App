import 'dart:async';
import 'package:cryptoexchange_mobile_app/models/order_level.dart';
import 'package:cryptoexchange_mobile_app/repositories/orderbook_repository.dart';
import 'package:flutter/material.dart';

class OrderBookProvider extends ChangeNotifier {
  final OrderBookRepository repository;

  OrderBookProvider(this.repository);
  List<OrderLevel> bids = [];
  List<OrderLevel> asks = [];
  // List asks = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  StreamSubscription? _sub;
  String _currentSymbol = '';

  DateTime _lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  Future<void> start(String symbol) async {
    final s = symbol.toLowerCase();

    // tránh reconnect trùng symbol
    if (_currentSymbol == s && _sub != null) return;

    _currentSymbol = s;

    // reset UI ngay khi đổi coin
    bids = [];
    asks = [];
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _sub?.cancel();
      await repository.subscribe(s);

      // _sub = repository.orderBookStream.listen(
      //   (orderBook) {
      //     final now = DateTime.now();
      //     if (now.difference(_lastUpdate).inMilliseconds < 500) return;
      //     _lastUpdate = now;

      //     // KHÔNG SORT – chỉ gán trực tiếp
      //     bids = orderBook.bids.take(10).toList();
      //     asks = orderBook.asks.take(10).toList();

      //     _isLoading = false;
      //     notifyListeners();
      //   },
      //   onError: (err) {
      //     _isLoading = false;
      //     _errorMessage = err.toString();
      //     notifyListeners();
      //   },
      // );
      _sub = repository.orderBookStream.listen((orderBook) {
        final now = DateTime.now();
        if (now.difference(_lastUpdate).inMilliseconds < 200) return;
        _lastUpdate = now;

        bids = orderBook.bids;
        asks = orderBook.asks;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
    repository.unsubscribe();
  }

  @override
  void dispose() {
    stop();
    repository.dispose();
    super.dispose();
  }
}
