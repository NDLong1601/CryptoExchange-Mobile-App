import 'package:cryptoexchange_mobile_app/screens/home/home_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/onboarding/onboarding_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/settings/settings.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String settings = '/settings';

  Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    AppRoute.home: (context) => const HomeScreen(),
    AppRoute.onboarding: (context) => const OnboardingScreen(),
    AppRoute.settings: (context) => const SettingsScreen(),
  };
}