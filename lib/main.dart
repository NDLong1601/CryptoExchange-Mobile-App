import 'package:cryptoexchange_mobile_app/core/theme/app_theme.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
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
        ChangeNotifierProvider(create: (_) => CoinProvider()),
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
