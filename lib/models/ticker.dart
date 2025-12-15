import 'package:json_annotation/json_annotation.dart';
part 'ticker.g.dart';

@JsonSerializable()
class Ticker {
  @JsonKey(name: 's')
  final String symbol;

  @JsonKey(name: 'c')
  final String lastPrice;

  @JsonKey(name: 'P')
  final String priceChangePercent;

  Ticker({
    required this.lastPrice,
    required this.symbol,
    required this.priceChangePercent,
  });

  factory Ticker.fromJson(Map<String, dynamic> json) => _$TickerFromJson(json);
}
