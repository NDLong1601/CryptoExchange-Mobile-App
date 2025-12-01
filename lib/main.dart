import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      initialRoute: AppRoute.onboarding,
      routes: AppRoute().routes,
    );
  }
}
