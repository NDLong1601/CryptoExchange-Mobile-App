import 'order_level.dart';

class OrderBook {
  final List<OrderLevel> bids;
  final List<OrderLevel> asks;

  OrderBook({
    required this.bids,
    required this.asks,
  });

  factory OrderBook.fromJson(Map<String, dynamic> json) {
    final bids = (json['b'] as List)
        .map((e) => OrderLevel.fromList(e))
        .where((e) => e.amount > 0)
        .toList();

    final asks = (json['a'] as List)
        .map((e) => OrderLevel.fromList(e))
        .where((e) => e.amount > 0)
        .toList();

    return OrderBook(bids: bids, asks: asks);
  }
}
