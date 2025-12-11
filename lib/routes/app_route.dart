import 'package:cryptoexchange_mobile_app/screens/bottom_tab/bottom_tab.dart';
import 'package:cryptoexchange_mobile_app/screens/favorites/favorites_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/home/home_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/onboarding/onboarding_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/setting/setting_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/trade_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/trading_chart/trading_chart_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String settings = '/settings';
  static const String favorite = '/favorites';
  static const String wallet = '/wallet';
  static const String trade = '/trade';
  static const String market = '/market';
  static const String bottomTab = '/bottom_tab';
  static const String tradingChartScreen = '/trading_chart_screen';

  Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    AppRoute.home: (context) => const HomeScreen(),
    AppRoute.onboarding: (context) => const OnboardingScreen(),
    AppRoute.settings: (context) => const SettingsScreen(),
    AppRoute.favorite: (context) => const FavoritesScreen(),
    AppRoute.trade: (context) => const TradeScreen(),
    AppRoute.market: (context) => const TradeScreen(),
    AppRoute.wallet: (context) => const TradeScreen(),
    AppRoute.bottomTab: (context) => const BottomTab(),
    AppRoute.tradingChartScreen: (context) => const TradingChartScreen(),
  };
}
