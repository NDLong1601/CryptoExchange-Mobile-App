// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
  symbol: json['s'] as String,
  priceChangePercent: json['P'] as String,
  currentPrice: json['c'] as String,
  volume: json['v'] as String,
);

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
  's': instance.symbol,
  'P': instance.priceChangePercent,
  'c': instance.currentPrice,
  'v': instance.volume,
};
