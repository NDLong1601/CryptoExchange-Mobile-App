import 'package:json_annotation/json_annotation.dart';

class OrderLevel {
  @JsonKey(name: 'b')
  final double price;

  @JsonKey(name: 'a')
  final double amount;

  OrderLevel({
    required this.price,
    required this.amount,
  });

  factory OrderLevel.fromList(List<dynamic> data) {
    return OrderLevel(
      price: double.parse(data[0]),
      amount: double.parse(data[1]),
    );
  }
}
