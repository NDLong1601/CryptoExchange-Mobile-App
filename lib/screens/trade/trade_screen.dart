import 'package:cryptoexchange_mobile_app/components/app_tab_bar.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/providers/orderbook_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/open_orders_section.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/trade_order_book.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/trade_order_book_header.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/trade_order_form.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/widget/trade_realtime_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  int _tabIndex = 0;
  final _tabs = const ['Spot', 'Margin', 'Grid', 'Fiat'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coinP = context.read<CoinProvider>();
      context.read<OrderBookProvider>().start(coinP.selectedSymbol);

      /// listen khi đổi coin
      coinP.addListener(_onCoinChanged);
    });
  }

  void _onCoinChanged() {
    final coinP = context.read<CoinProvider>();
    context.read<OrderBookProvider>().start(coinP.selectedSymbol);
  }

  @override
  void dispose() {
    final coinP = context.read<CoinProvider>();
    coinP.removeListener(_onCoinChanged);

    context.read<OrderBookProvider>().stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Trade', style: context.theme.textTheme.bodyLarge),
        actions: const [Icon(Icons.favorite_outline), SizedBox(width: 12)],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                AppTabBar(
                  tabs: _tabs,
                  currentIndex: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TradeRealtimeHeader(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.tradingChartScreen,
                          );
                        },
                        child: SvgPicture.asset(AppAssetsPath.chart),
                      ),
                    ],
                  ),
                ),
                OrderBookHeaderControls(),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: context.sh * 420 / 812,
                      width: context.sw * 144 / 375,
                      child: TradeOrderBook(limit: 10),
                    ),
                    SizedBox(
                      height: context.sh * 420 / 812,
                      width: context.sw * 180 / 375,
                      child: TradeOrderForm(
                        symbol: 'BTC',
                        quote: 'USDT',
                        available: 1000,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                OpenOrdersSection(
                  onMore: () {
                    // Navigator.pushNamed(context, AppRoute.openOrders);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
