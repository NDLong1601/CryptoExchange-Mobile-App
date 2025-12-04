class StringHelper {
  /// Formats a raw symbol string into a more readable trading pair format.
  /// Example: "btcusdt" -> "BTC/USD"
  static String formatSymbolPair(String raw) {
    final s = raw.toUpperCase().replaceAll("USDT", "");
    return "$s/USD";
  }
}
