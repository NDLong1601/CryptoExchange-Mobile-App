import 'package:cryptoexchange_mobile_app/core/theme/app_theme.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/favorite_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/open_orders_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/orderbook_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/repositories/coin_repository.dart';
import 'package:cryptoexchange_mobile_app/repositories/favorite_repository.dart';
import 'package:cryptoexchange_mobile_app/repositories/orderbook_repository.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/services/binance_websocket_service.dart';
import 'package:cryptoexchange_mobile_app/services/orderbook_websocket_service.dart';
import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();

  final completed = await StorageService.instance.isOnboardingCompleted();
  debugPrint('Onboarding completed status at app start: $completed');

  runApp(
    MultiProvider(
      providers: [
        /// Global Providers ( global state )
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider(create: (context) => BinanceWebsocketService()),
        Provider(create: (context) => OrderBookWebSocketService()),
        Provider(
          create: (context) =>
              OrderBookRepository(context.read<OrderBookWebSocketService>()),
        ),
        Provider(create: (_) => FavoriteRepository(StorageService.instance)),

        Provider(
          create: (context) => CoinRepository(
            binanceWebsocketService: context.read<BinanceWebsocketService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CoinProvider(
            coinRepository: context.read<CoinRepository>(),
            favoriteRepository: context.read<FavoriteRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              OrderBookProvider(context.read<OrderBookRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => OpenOrdersProvider()..addMockDataIfEmpty(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(
            favoriteRepository: context.read<FavoriteRepository>(),
            coinRepository: context.read<CoinRepository>(),
          ),
        ),
      ],
      child: MyApp(
        initialRoute: completed ? AppRoute.bottomTab : AppRoute.onboarding,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: AppRoute().routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
