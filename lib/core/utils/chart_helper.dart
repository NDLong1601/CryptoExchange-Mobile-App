import 'dart:async';
import 'dart:math';

import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:flutter/material.dart';

class ChartController {
  static final ChartController _instance = ChartController._internal();
  factory ChartController() => _instance;
  ChartController._internal();

  final _rand = Random();

  final Map<String, String> _chartBySymbol = {};
  final Map<String, Timer> _timers = {};

  static const String _downChart = AppAssetsPath.graph4;

  static const List<String> _upCharts = [
    AppAssetsPath.graph2,
    AppAssetsPath.graph3,
    AppAssetsPath.graph5,
    AppAssetsPath.graph6,
  ];

  String chartOf(String symbol) {
    return _chartBySymbol[symbol] ?? AppAssetsPath.graph2;
  }

  void startWatching({
    required String symbol,
    required String percentChange,
    required VoidCallback onTick,
  }) {
    // Nếu đã có timer → không tạo lại
    if (_timers.containsKey(symbol)) return;

    // Set chart lần đầu
    _updateChart(symbol, percentChange);

    _timers[symbol] = Timer.periodic(const Duration(seconds: 5), (_) {
      _updateChart(symbol, percentChange);
      onTick();
    });
  }

  void _updateChart(String symbol, String percentChange) {
    final percent = double.tryParse(percentChange.replaceAll('%', '')) ?? 0;

    if (percent < 0) {
      _chartBySymbol[symbol] = _downChart;
    } else {
      _chartBySymbol[symbol] = _upCharts[_rand.nextInt(_upCharts.length)];
    }
  }

  void stopWatching(String symbol) {
    _timers[symbol]?.cancel();
    _timers.remove(symbol);
    _chartBySymbol.remove(symbol);
  }

  void disposeAll() {
    for (final t in _timers.values) {
      t.cancel();
    }
    _timers.clear();
    _chartBySymbol.clear();
  }
}
