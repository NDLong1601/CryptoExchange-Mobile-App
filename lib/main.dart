// import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
// import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
// import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
// import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   final coinProvider = CoinProvider();
//   coinProvider.startListening();
//   WidgetsFlutterBinding.ensureInitialized();
//   // Check onboarding completion status
//   final storage = StorageService();
//   final completed = await storage.isOnboardingCompleted();
//   debugPrint('Onboarding completed status at app start: $completed');
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),
//         ChangeNotifierProvider(create: (_) => CoinProvider()),
//       ],
//       child: MyApp(
//         initialRoute: completed ? AppRoute.home : AppRoute.onboarding,
//       ),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;

//   const MyApp({super.key, required this.initialRoute});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: initialRoute,
//       routes: AppRoute().routes,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: Provider.of<ThemeProvider>(context).themeMode,
//     );
//   }
// }

import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check onboarding completion
  final storage = StorageService();
  final completed = await storage.isOnboardingCompleted();
  debugPrint('Onboarding completed status at app start: $completed');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CoinProvider()..startListening()),
      ],
      child: MyApp(
        initialRoute: completed ? AppRoute.home : AppRoute.onboarding,
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
