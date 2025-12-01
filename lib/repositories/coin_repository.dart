import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/services/binance_websocket_service.dart';

class CoinRepository {
  // Coin repository implementation
  final BinanceWebsocketService _binanceWebsocketService =
      BinanceWebsocketService();

  /// Expose Stram<Coin>
  Stream<Coin> get coinStream => _binanceWebsocketService.coinStream;

  Future<void> subscribeToCoinTicker(String symbol) async {
    await _binanceWebsocketService.connectToTickers(symbol: symbol);
  }
}
