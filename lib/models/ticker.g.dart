// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticker _$TickerFromJson(Map<String, dynamic> json) => Ticker(
  lastPrice: json['c'] as String,
  symbol: json['s'] as String,
  priceChangePercent: json['P'] as String,
);

// Map<String, dynamic> _$TickerToJson(Ticker instance) => <String, dynamic>{
//   's': instance.symbol,
//   'c': instance.lastPrice,
//   'P': instance.priceChangePercent,
// };
