import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_text_header.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
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

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  bool isDragging = false;
  final ChartController chartController = ChartController();
  bool _chartBound = false;

  @override
  void initState() {
    // _slidableController.dismissGesture
    // _slidableController.openEndActionPane();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {},
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              AppTextHeader(),
              SizedBox(height: 13),
              Consumer<FavoriteProvider>(
                builder: (_, favoriteProvider, _) {
                  return ListView.separated(
                    itemBuilder: (context, state) {
                      final coin = favoriteProvider.favoriteCoins[state];
                      final favoriteCoins = favoriteProvider.favoriteCoins;

                      if (favoriteProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (favoriteCoins.isEmpty) {
                        return const Center(child: Text("No market data"));
                      }

                      _bindChartsOnce(favoriteCoins);
                      return Slidable(
                        key: ValueKey(coin.symbol),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.zero,
                              onPressed: (_) {
                                favoriteProvider.toggleFavoriteToken(
                                  coin.symbol,
                                );
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Remove',
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ],
                        ),

                        // The child of the Slidable is what the user sees when the
                        // component is not dragged.
                        child: Center(
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
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 7),
                    itemCount: favoriteProvider.favoriteCoins.length,
                  );
                },
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
