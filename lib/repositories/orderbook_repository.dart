import 'package:cryptoexchange_mobile_app/models/order_book.dart';
import 'package:cryptoexchange_mobile_app/services/orderbook_websocket_service.dart';

class OrderBookRepository {
  final OrderBookWebSocketService _service;

  OrderBookRepository(this._service);

  Stream<OrderBook> get orderBookStream => _service.stream;

  Future<void> subscribe(String symbol) async {
    await _service.connect(symbol);
  }

  Future<void> unsubscribe() async {
    await _service.disconnect();
  }

  void dispose() {
    _service.dispose();
  }
}
