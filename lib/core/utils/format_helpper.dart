import 'package:intl/intl.dart';

class FormatHelper {
  static final NumberFormat _priceFormatter =
      NumberFormat('#,##0.00', 'en_US');

  static final NumberFormat _volumeFormatter =
      NumberFormat.compact(locale: 'en_US');

  /// ===== PRICE =====
  /// 30113.8 -> 30,113.80
  static String price(dynamic value, {int fraction = 2}) {
    final v = _toDouble(value);
    return NumberFormat('#,##0.${'0' * fraction}', 'en_US').format(v);
  }

  /// ===== PERCENT =====
  /// "2.76" -> "+2.76%"
  /// "-1.39" -> "-1.39%"
  static String percent(dynamic value, {int fraction = 2}) {
    final v = _toDouble(value);
    final sign = v > 0 ? '+' : '';
    return '$sign${v.toStringAsFixed(fraction)}%';
  }

  /// ===== USD APPROX =====
  /// 30113.8 -> ≈$30,113.80
  static String approxUsd(dynamic value, {int fraction = 2}) {
    return '≈\$${price(value, fraction: fraction)}';
  }

  /// ===== VOLUME =====
  /// 2199038684 -> 2.19B
  static String volume(dynamic value) {
    final v = _toDouble(value);
    return _volumeFormatter.format(v);
  }

  /// ===== SYMBOL =====
  /// btcusdt -> BTC/USDT
  static String symbolPair(String raw) {
    final s = raw.toUpperCase();
    if (s.endsWith('USDT')) {
      return '${s.replaceAll('USDT', '')}/USDT';
    }
    return s;
  }

  /// ===== INTERNAL =====
  static double _toDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }
}
