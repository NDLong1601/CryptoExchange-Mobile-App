import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/services/binance_websocket_service.dart';
import 'package:flutter/material.dart';

class CoinRepository {
  final BinanceWebsocketService _binanceWebsocketService =
      BinanceWebsocketService();

  /// Expose stream of realtime coin updates
  Stream<List<Coin>> get coinStream => _binanceWebsocketService.coinStream;

  /// Subscribe to multiple coin symbols (20 coins)
  Future<void> subscribeToCoins(List<String> symbols) async {
    await _binanceWebsocketService.connectToTickers(symbols: symbols);
    debugPrint('🔌 Subscribed to Binance streams: $symbols');
  }

  /// Disconnect WebSocket (optional)
  void disconnect() {
    _binanceWebsocketService.disconnect();
    debugPrint('Disconnected from Binance WebSocket');
  }
}
