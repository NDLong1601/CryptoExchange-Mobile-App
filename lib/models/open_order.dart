import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helpper.dart';

class OpenOrder {
  final String symbol;
  final OrderSide side;
  final String orderType;
  final double price;
  final double amount;
  final double filledRatio;
  final DateTime createdAt;

  OpenOrder({
    required this.symbol,
    required this.side,
    required this.orderType,
    required this.price,
    required this.amount,
    required this.filledRatio,
    required this.createdAt,
  });

  double get total => price * amount;

  String get pairDisplay => FormatHelper.symbolPair(symbol);

  String get sideLabel => side == OrderSide.sell ? 'Sell' : 'Buy';

  String get typeLabel => '$sideLabel $orderType';
}
