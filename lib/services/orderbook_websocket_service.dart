import 'dart:async';
import 'dart:convert';

import 'package:cryptoexchange_mobile_app/models/order_book.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderBookWebSocketService {
  static const String _baseUrl = 'wss://stream.binance.com:9443/ws/';

  WebSocketChannel? _channel;

  final StreamController<OrderBook> _controller =
      StreamController<OrderBook>.broadcast();

  Stream<OrderBook> get stream => _controller.stream;

  Future<void> connect(String symbol) async {
    final s = symbol.toLowerCase();

    await disconnect();

    final url = '$_baseUrl$s@depth';
    debugPrint('OrderBook WS connect: $url');

    _channel = WebSocketChannel.connect(Uri.parse(url));

    _channel!.stream.listen(
      (event) {
        final json = jsonDecode(event);
        final orderBook = OrderBook.fromJson(json);
        _controller.add(orderBook);
      },
      onError: (e) {
        debugPrint('OrderBook WS error: $e');
      },
    );
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }

  void dispose() {
    disconnect();
    _controller.close();
  }
}
