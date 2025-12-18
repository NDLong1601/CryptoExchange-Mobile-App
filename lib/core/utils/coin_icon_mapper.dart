import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';

class CoinIconMapper {
  static final Map<String, String> _coinIconMap = {
    'btc': AppAssetsPath.bitcoin,
    'eth': AppAssetsPath.ethereum,
    'sol': AppAssetsPath.solana,
    'ada': AppAssetsPath.cardano,
    'xrp': AppAssetsPath.xrp,
    'link': AppAssetsPath.chainlink,
    'xlm': AppAssetsPath.stellar,
    'ape': AppAssetsPath.ape,
    'bnb': AppAssetsPath.bnb,
    'dot': AppAssetsPath.polkadot,
    'matic': AppAssetsPath.matic,
    'doge': AppAssetsPath.dogecoin,
    'avax': AppAssetsPath.avalance,
    'ltc': AppAssetsPath.litecoin,
    'atom': AppAssetsPath.cosmos,
    'near': AppAssetsPath.near,
    'fil': AppAssetsPath.filecoin,
    'uni': AppAssetsPath.uniswap,
    'trx': AppAssetsPath.tron,
    'egld': AppAssetsPath.multiversx,
  };

  static String fromSymbol(String rawSymbol) {
    final normalized = _normalize(rawSymbol);
    return _coinIconMap[normalized] ?? AppAssetsPath.coindefault;
  }

  static String _normalize(String rawSymbol) {
    return rawSymbol
        .toLowerCase()
        .replaceAll('usdt', '')
        .replaceAll('/', '');
  }
}