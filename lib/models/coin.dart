import 'package:json_annotation/json_annotation.dart';
part 'coin.g.dart';

///Sample coin json data from Binance WebSocket API
// {
//   "stream": "btcusdt@ticker",
//   "data": {
//     "e": "24hrTicker",
//     "E": 1764596958029,
//     "s": "BTCUSDT",
//     "p": "-5866.04000000",
//     "P": "-6.400",
//     "w": "87510.48370860",
//     "x": "91660.00000000",
//     "c": "85793.97000000",
//     "Q": "0.00052000",
//     "b": "85793.96000000",
//     "B": "6.72263000",
//     "a": "85793.97000000",
//     "A": "0.00121000",
//     "o": "91660.01000000",
//     "h": "91850.00000000",
//     "l": "84756.00000000",
//     "v": "25128.85989000",
//     "q": "2199038684.01944220",
//     "O": 1764510558011,
//     "C": 1764596958011,
//     "F": 5583382302,
//     "L": 5588236242,
//     "n": 4853941,
//     "naming_convention": 4853941
//   }
// }

@JsonSerializable()
class Coin {
  @JsonKey(name: 's')
  final String symbol;

  @JsonKey(name: 'P')
  final String priceChangePercent;

  @JsonKey(name: 'c')
  final String currentPrice;

  @JsonKey(name: 'v')
  final String volume;

  Coin({
    required this.symbol,
    required this.priceChangePercent,
    required this.currentPrice,
    required this.volume,
  });

  /// from json
  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$CoinToJson(this);

  /// Convert price (string -> double)
  double get price => double.tryParse(currentPrice) ?? 0.0;

  /// Convert percent change (string -> double)
  double get percent => double.tryParse(priceChangePercent) ?? 0.0;

  /// True if price increased
  bool get isPositive => percent >= 0;

  /// Price formatted, e.g. "27,154.25"
  String get formattedPrice {
    final p = price;
    if (p >= 1000) {
      return p.toStringAsFixed(2);
    }
    return p.toString();
  }

  /// Percent formatted: "+3.14%" hoặc "-1.25%"
  String get formattedPercent {
    final pct = percent.toStringAsFixed(2);
    if (percent >= 0) {
      return "+$pct%";
    }
    return "$pct%";
  }
}
