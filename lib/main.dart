import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  final String name;

  const User({required this.name});

  /// Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.name == name;
  }

  /// Override hashCode
  @override
  int get hashCode => name.hashCode;

  /// Example hashCode
  /// 1316631139613
  /// 5115710751057
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final user = User(name: 'Alice');
  // final user1 = User(name: 'Alice');

  // print(user == user1);

  // Check onboarding completion
  await StorageService.instance.init();

  final completed = await StorageService.instance.isOnboardingCompleted();
  debugPrint('Onboarding completed status at app start: $completed');

  runApp(
    MultiProvider(
      providers: [
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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
    );
  }
}
