// lib/providers/open_orders_provider.dart
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:flutter/material.dart';
import '../models/open_order.dart';

class OpenOrdersProvider extends ChangeNotifier {
  final List<OpenOrder> _orders = [];

  bool _hideOtherPairs = false;
  bool get hideOtherPairs => _hideOtherPairs;

  List<OpenOrder> get allOrders => List.unmodifiable(_orders);

  List<OpenOrder> visibleOrders(String selectedSymbol) {
    final s = selectedSymbol.toUpperCase();
    if (!_hideOtherPairs) return List.unmodifiable(_orders);
    return _orders.where((o) => o.symbol.toUpperCase() == s).toList();
  }

  void toggleHideOtherPairs(bool value) {
    _hideOtherPairs = value;
    notifyListeners();
  }

  void addMockDataIfEmpty() {
    if (_orders.isNotEmpty) return;

    _orders.addAll([
      OpenOrder(
        symbol: 'XRPUSDT',
        side: OrderSide.sell,
        orderType: 'Limit',
        price: 1.912,
        amount: 55.5,
        filledRatio: 0,
        createdAt: DateTime(2022, 7, 1, 8, 33, 45),
      ),
      OpenOrder(
        symbol: 'THETAUSDT',
        side: OrderSide.buy,
        orderType: 'Limit',
        price: 8.9,
        amount: 83.03,
        filledRatio: 0,
        createdAt: DateTime(2022, 7, 1, 8, 20, 15),
      ),
    ]);

    notifyListeners();
  }

  void cancelOrder(OpenOrder order) {
    _orders.remove(order);
    notifyListeners();
  }

  void cancelAll() {
    _orders.clear();
    notifyListeners();
  }
}
