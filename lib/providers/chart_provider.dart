import 'dart:async';
import 'dart:math';

import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:flutter/material.dart';

class ChartProvider extends ChangeNotifier {
  static final ChartProvider _instance = ChartProvider._internal();
  factory ChartProvider() => _instance;
  ChartProvider._internal() {
    _start();
  }

  final _rand = Random();
  Timer? _timer;

  final Map<String, String> _chartBySymbol = {};

  static const String _downChart = AppAssetsPath.graph4;

  static const List<String> _upCharts = [
    AppAssetsPath.graph2,
    AppAssetsPath.graph3,
    AppAssetsPath.graph5,
    AppAssetsPath.graph6,
  ];

  void bindCoin(String symbol, String percentChange) {
    _update(symbol, percentChange);
  }

  String chartOf(String symbol) {
    return _chartBySymbol[symbol] ?? AppAssetsPath.graph2;
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      notifyListeners();
    });
  }

  void _update(String symbol, String percentChange) {
    final percent = double.tryParse(percentChange.replaceAll('%', '')) ?? 0;
    _chartBySymbol[symbol] = percent < 0
        ? _downChart
        : _upCharts[_rand.nextInt(_upCharts.length)];
  }

  void disposeAll() {
    _timer?.cancel();
    _chartBySymbol.clear();
  }
}
