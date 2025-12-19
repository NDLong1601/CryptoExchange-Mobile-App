class StringHelper {
  /// Format a raw symbol string into a more readable trading pair format
  /// Example : "btcusdt" -> "BTC/USD"
  static String formatSymbolPair(String raw) {
    final s = raw.toUpperCase().replaceAll("USDT", "");
    return "$s/USD";
  }

  static String readableName(String rawSymbol) {
    const nameMap = {
      "btc": "Bitcoin",
      "eth": "Ethereum",
      "sol": "Solana",
      "bnb": "BNB",
      "ada": "Cardano",
      "xrp": "XRP",
      "dot": "Polkadot",
      "matic": "Polygon",
      "doge": "Dogecoin",
      "avax": "Avalanche",
      "link": "Chainlink",
      "ltc": "Litecoin",
      "atom": "Cosmos",
      "near": "NEAR",
      "fil": "Filecoin",
      "uni": "Uniswap",
      "trx": "TRON",
      "xlm": "Stellar",
      "ape": "ApeCoin",
      "egld": "MultiversX",
    };
    final baseSymbol = rawSymbol.toLowerCase().replaceAll("usdt", "");
    return nameMap[baseSymbol] ?? rawSymbol.toUpperCase();
  }

  static String formatPercent(String raw) {
    final v = double.tryParse(raw) ?? 0;
    final sign = v >= 0 ? '+' : '';
    return '$sign${v.toStringAsFixed(2)}%';
  }

    /// format number to currency string
  String formatCurrency(num value, {String symbol = '\$'}) {
    final sign = value < 0 ? '-' : '';
    final absValue = value.abs().toDouble();
    final parts = absValue.toStringAsFixed(2).split('.');
    final integer = parts[0];
    final decimal = parts[1];
    final withCommas = integer.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return '$sign$symbol $withCommas.$decimal';
  }
}