import 'package:cryptoexchange_mobile_app/services/storage_service.dart';

class FavoriteRepository {
  final StorageService storageService;
  FavoriteRepository(this.storageService);

  /// Stream of favorite tokens
  Stream<List<String>> get favoriteTokensStream =>
      storageService.favoriteTokensStream;

  /// toggle favorite token
  Future<void> toggleFavoriteToken(String symbol) async {
    await storageService.toggleFavoriteToken(symbol);
  }

  /// get favorite tokens
  List<String> getFavoriteTokens() {
    return storageService.getFavoriteTokens();
  }
}
