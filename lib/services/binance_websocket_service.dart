import 'dart:async';
import 'dart:convert';

import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:flutter/rendering.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebsocketService {
  BinanceWebsocketService();

  /// Implement websocket channel connection to Binance API

  /// Declare websocket url
  static const String _binanceWsUrl =
      'wss://stream.binance.com:9443/stream?streams=';

  /// Declare websocket channel variable
  WebSocketChannel? _tickerWebSocketChannel;

  /// Delare stream variable
  final StreamController<Coin> _coinStreamController =
      StreamController<Coin>.broadcast();

  /// Expose coin stream -> for listening
  Stream<Coin> get coinStream => _coinStreamController.stream;

  /// Implement methods to connect, disconnect, and listen to streams
  Future<void> connectToTickers({required List<String> symbols}) async {
    try {
      final streamParams = symbols
          .map((s) => "${s.toLowerCase()}@ticker")
          .join('/');
      final String url = "$_binanceWsUrl$streamParams";
      debugPrint('🔌 Connecting to Binance WebSocket: $url');
      _tickerWebSocketChannel = WebSocketChannel.connect(Uri.parse(url));

      if (_tickerWebSocketChannel == null) {
        throw Exception('Failed to connect to Binance WebSocket');
      }

      _tickerWebSocketChannel?.stream.listen((data) {
        /// Handle incoming data
        final jsonData = jsonDecode(data);
        if (jsonData == null || jsonData['data'] == null) {
          debugPrint('Invalid data received from WebSocket: $data');
          return;
        }
        final coinData = Coin.fromJson(jsonData['data']);
        _coinStreamController.add(coinData);
        debugPrint('Received data: $data');
      });
    } catch (e, stackTrace) {
      debugPrint('Error connecting to Binance WebSocket: $e');
      debugPrint("stackTrace: $stackTrace");
      // Handle connection errors
    }
  }

  
  Future<void> disconnect() async {
    try {
      await _tickerWebSocketChannel?.sink.close();
      _tickerWebSocketChannel = null;
      debugPrint("Binance WS disconnected.");
    } catch (e) {
      debugPrint("Error during WS disconnect: $e");
    }
  }

  void dispose() {
    _coinStreamController.close();
    disconnect();
  }
}
