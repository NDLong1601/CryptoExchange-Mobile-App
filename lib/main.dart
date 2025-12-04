import 'dart:async';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/theme_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check onboarding status before running the app
  final storage = StorageService();
  final completed = await storage.isOnboardingCompleted();
  debugPrint('Onboarding completed status at app start: $completed');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CoinProvider()),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: AppRoute().routes,

      // Theme hiện tại
      theme: ThemeData.light(),
    );
  }
}

class DemoBinanceWebSocket extends StatefulWidget {
  const DemoBinanceWebSocket({super.key});

  @override
  State<DemoBinanceWebSocket> createState() => _DemoBinanceWebSocketState();
}

class _DemoBinanceWebSocketState extends State<DemoBinanceWebSocket> {
  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      context.read<CoinProvider>().subscribeToTicker('btcusdt');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CoinProvider>(
        builder: (_, coinProvider, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Demo Binance WebSocket')),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'BTCUSDT Price: ${coinProvider.coin?.currentPrice ?? 'Loading...'}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Change: ${coinProvider.coin?.priceChangePercent ?? 'Loading...'}%',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ],
                ),
              ),
              // Display coin data here using Consumer<DemoProvider>
            ],
          );
        },
      ),
    );
  }
}

/// Demo Stream && Stream Controller via StreamBuilder

class DemoStream extends StatefulWidget {
  const DemoStream({super.key});

  @override
  State<DemoStream> createState() => _DemoStreamState();
}

class _DemoStreamState extends State<DemoStream> {
  int counter = 0;

  /// Signle subscription stream controller
  // StreamController streamController = StreamController<int>();

  /// Broadcast stream controller
  StreamController streamController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    /// Close the stream controller when the widget is disposed
    /// to prevent memory leaks
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Demo Stream Builder')),
          StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              return Text(
                'Counter: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          Text('Another StreamBuilder listening to the same stream:'),
          StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              return Text(
                'Counter: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              for (int i = 0; i < 100; i++) {
                counter++;
                await Future.delayed(const Duration(milliseconds: 500));
                streamController.sink.add(counter);
              }
            },
            child: const Text('Increment Counter'),
          ),
          const SizedBox(height: 20),
          Text('Another StreamBuilder listening to the same stream:'),
          StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              return Text(
                'Counter: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
        ],
      ),
    );
  }
}
