class OrderLevel {
  final double price;

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
