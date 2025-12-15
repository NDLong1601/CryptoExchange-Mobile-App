import 'dart:async';
import 'dart:convert';

import 'package:cryptoexchange_mobile_app/models/ticker.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradeTickerWebsocketService {
  static const String _tickerWsUrl = 'wss://stream.binance.com:9443/ws/';

  WebSocketChannel? _channel;

  final StreamController<Ticker> _tickerCtrl =
      StreamController<Ticker>.broadcast();

  Stream<Ticker> get tickerStream => _tickerCtrl.stream;

  Future<void> connect({required String symbol}) async {
    try {
      final s = symbol.toLowerCase();
      disconnect;
      final url = '$_tickerWsUrl$s@ticker';
      debugPrint('Ticker WS connect: $url');
      _channel = WebSocketChannel.connect(Uri.parse(url));

      if (_channel == null) {
        throw Exception('Failed to connect to Ticker WebSocket');
      }

      _channel!.stream.listen(
        (raw) {
          // debugPrint('📩 Ticker raw: $raw');

          final Map<String, dynamic> json =
              jsonDecode(raw) as Map<String, dynamic>;
          final ticker = Ticker.fromJson(json);

          _tickerCtrl.add(ticker);
        },
        onError: (e) {
          debugPrint('Ticker WS error: $e');
          _tickerCtrl.addError(e);
        },
        onDone: () {
          debugPrint('Ticker WS closed');
        },
      );
    } catch (e, stackTrace) {
      debugPrint('Error connecting to Ticker WebSocket: $e');
      debugPrint("stackTrace: $stackTrace");
    }
  }

  Future<void> disconnect() async {
    try {
      await _channel?.sink.close();
      _channel = null;
      debugPrint("Trade Ticker WS disconnected.");
    } catch (e) {
      debugPrint("Error during WS disconnect: $e");
    }
  }

  void dispose() {
    _tickerCtrl.close();
    disconnect();
  }
}
