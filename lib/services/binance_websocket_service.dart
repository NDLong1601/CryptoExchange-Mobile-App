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



// class BinanceWebsocketService {
//   BinanceWebsocketService._internal();
//   static final BinanceWebsocketService _instance = BinanceWebsocketService._internal();
//   factory BinanceWebsocketService() => _instance;

//   static const String _baseWsUrl =
//       'wss://stream.binance.com:9443/stream?streams=';

//   WebSocketChannel? _channel;

//   /// Broadcast stream toàn bộ Coin updates
//   final StreamController<Coin> _coinController =
//       StreamController<Coin>.broadcast();

//   Stream<Coin> get coinStream => _coinController.stream;

//   Timer? _reconnectTimer;

//   bool _isConnecting = false;

//   Future<void> connect(List<String> symbols) async {
//     if (_isConnecting) return;
//     _isConnecting = true;

//     try {
//       final streamPaths =
//           symbols.map((s) => "${s.toLowerCase()}@ticker").join('/');

//       final fullUrl = "$_baseWsUrl$streamPaths";

//       debugPrint("🔌 Connecting WebSocket: $fullUrl");

//       _channel = WebSocketChannel.connect(Uri.parse(fullUrl));

//       _listenWebSocket();

//       _isConnecting = false;
//     } catch (e) {
//       debugPrint("❌ WebSocket connection error: $e");
//       _scheduleReconnect(symbols);
//     }
//   }

//   void _listenWebSocket() {
//     _channel?.stream.listen(
//       (data) {
//         try {
//           final jsonData = jsonDecode(data);

//           // Binance multi-stream format: { stream: "...", data: {...ticker...} }
//           if (jsonData == null ||
//               jsonData["data"] == null ||
//               jsonData["data"]["c"] == null) {
//             debugPrint("⚠️ Invalid WebSocket data: $data");
//             return;
//           }

//           final coin = Coin.fromJson(jsonData["data"]);
//           _coinController.add(coin);
//         } catch (e) {
//           debugPrint("⚠️ Error parsing ticker JSON: $e");
//         }
//       },
//       onDone: () {
//         debugPrint("⚠️ WebSocket closed, reconnecting...");
//         _scheduleReconnect();
//       },
//       onError: (error) {
//         debugPrint("❌ WebSocket error: $error");
//         _scheduleReconnect();
//       },
//     );
//   }


//   void _scheduleReconnect([List<String>? symbols]) {
//     if (_reconnectTimer != null) return;

//     _reconnectTimer = Timer(const Duration(seconds: 3), () {
//       _reconnectTimer = null;
//       if (symbols != null) {
//         connect(symbols);
//       }
//     });
//   }

//   void disconnect() {
//     debugPrint("🔌 Disconnect WebSocket");

//     _reconnectTimer?.cancel();
//     _reconnectTimer = null;

//     _channel?.sink.close();
//     _channel = null;
//   }

//   void dispose() {
//     disconnect();
//     _coinController.close();
//   }
// }
