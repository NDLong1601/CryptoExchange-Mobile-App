import 'dart:async';
import 'package:cryptoexchange_mobile_app/models/ticker.dart';
import 'package:cryptoexchange_mobile_app/services/orderbook_websocket_service.dart';
import 'package:flutter/cupertino.dart';

class TradeTickerRepository {
  final TradeTickerWebsocketService _tradeTickerWebsocketService;

  TradeTickerRepository(this._tradeTickerWebsocketService);

  Stream<Ticker> get tickerStream => _tradeTickerWebsocketService.tickerStream;

  // Subscribe to coin symbol
  Future<void> subscribe(String symbol) async {
    await _tradeTickerWebsocketService.connect(symbol: symbol);
    debugPrint("🔌 Subscribed to Trade Ticker streams: $symbol");
  }

  // Disconnect Websocket
  Future<void> unsubscribe() async {
    await _tradeTickerWebsocketService.disconnect();
    debugPrint('Disconnected from Ticker WebSocket');
  }

  void dispose() {
    _tradeTickerWebsocketService.dispose();
  }
}
