import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_slidable_action.dart';
import 'package:cryptoexchange_mobile_app/components/app_text_header.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/chart_helper.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ChartController chartController = ChartController();
  bool _chartBound = false;

  @override
  void dispose() {
    chartController.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: context.theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text('Favourites', style: context.theme.textTheme.bodyLarge),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsPath.filter,
              color: context.theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const AppTextHeader(),
              Divider(
                color: context.theme.dividerColor.withValues(alpha: 0.35),
              ),
              const SizedBox(height: 13),
              Expanded(
                child: Consumer<FavoriteProvider>(
                  builder: (_, favoriteProvider, _) {
                    final coins = favoriteProvider.favoriteCoins;

                    if (favoriteProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (coins.isEmpty) {
                      return const Center(child: Text("No favorite coins"));
                    }

                    _bindChartsOnce(coins);

                    return ListView.separated(
                      itemCount: coins.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final coin = coins[index];

                        return Slidable(
                          key: ValueKey(coin.symbol),
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: (72 * 2) / context.sw,
                            children: [
                              AppSlidableAction(
                                label: 'Move',
                                iconPath: AppAssetsPath.move,
                                backgroundColor: AppColor.green,
                                onPressed: () {},
                                borderRadius: BorderRadius.zero,
                              ),
                              AppSlidableAction(
                                label: 'Remove',
                                iconPath: AppAssetsPath.remove,
                                backgroundColor: AppColor.red,
                                onPressed: () {
                                  favoriteProvider.toggleFavoriteToken(
                                    coin.symbol,
                                  );
                                },
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                            ],
                          ),
                          child: RepaintBoundary(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.theme.cardColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: AppCardItem(
                                symbol: coin.symbol,
                                price: coin.currentPrice,
                                percentChange: coin.priceChangePercent,
                                volume: coin.volume,
                                topPrice: coin.topPrice,
                                lowPrice: coin.lowPrice,
                                chartPath: chartController.chartOf(coin.symbol),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
