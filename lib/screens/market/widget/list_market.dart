import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/core/utils/chart_helper.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMarket extends StatefulWidget {
  const ListMarket({super.key});

  @override
  State<ListMarket> createState() => _ListMarketState();
}

class _ListMarketState extends State<ListMarket> {
  final ChartController chartController = ChartController();
  bool _chartBound = false;

  @override
  void dispose() {
    chartController.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
      builder: (_, provider, _) {
        final coins = provider.coins;

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (coins.isEmpty) {
          return const Center(child: Text("No market data"));
        }

        _bindChartsOnce(coins);

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: coins.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final c = coins[index];

            return AppCardItem(
              symbol: c.symbol,
              price: c.currentPrice,
              percentChange: c.priceChangePercent,
              volume: c.volume,
              topPrice: c.topPrice,
              lowPrice: c.lowPrice,
              chartPath: chartController.chartOf(c.symbol),
            );
          },
        );
      },
    );
  }

  void _bindChartsOnce(List<Coin> coins) {
    if (_chartBound) return;
    _chartBound = true;

    for (final c in coins) {
      chartController.startWatching(
        symbol: c.symbol,
        percentChange: c.priceChangePercent,
        onTick: () {
          if (mounted) setState(() {});
        },
      );
    }
  }
}
