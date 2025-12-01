import 'package:cryptoexchange_mobile_app/screens/favorites/favorites_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/home_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/onboarding_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/settings.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/trade_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String settings = '/settings';
  static const String favorite = '/favorites';
  static const String wallet = '/wallet';
  static const String trade = '/trade';
  static const String market = '/market';

  Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    AppRoute.home: (context) => const HomeScreen(),
    AppRoute.onboarding: (context) => const OnboardingScreen(),
    AppRoute.settings: (context) => const SettingsScreen(),
    AppRoute.favorite: (context) => const FavoritesScreen(),
    AppRoute.trade: (context) => const TradeScreen(),
    AppRoute.market: (context) => const TradeScreen(),
    AppRoute.wallet: (context) => const TradeScreen(),
  };
}
