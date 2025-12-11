import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingChartScreen extends StatefulWidget {
  const TradingChartScreen({super.key});

  @override
  State<TradingChartScreen> createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
  final WebViewController controller = WebViewController();
  final String symbol = 'BTCUSDT';

  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          // 'https://www.tradingview.com/chart/?symbol=BINANCE%3A$symbol',
          'https://www.youtube.com/',
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Trading Chart')),
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
