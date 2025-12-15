import 'package:json_annotation/json_annotation.dart';
part 'coin.g.dart';

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
