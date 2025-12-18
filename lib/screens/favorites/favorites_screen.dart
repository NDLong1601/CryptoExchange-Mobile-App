import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/core/utils/coin_icon_mapper.dart';
import 'package:cryptoexchange_mobile_app/core/utils/string_helper.dart';
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
  late final SlidableController _slidableController;

  @override
  void initState() {
    _slidableController = SlidableController(this);
    // _slidableController.dismissGesture
    // _slidableController.openEndActionPane();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Consumer<FavoriteProvider>(
          builder: (_, favoriteProvider, _) {
            return ListView.separated(
              itemBuilder: (context, state) {
                final coin = favoriteProvider.favoriteCoins[state];

                return Slidable(
                  // controller: _slidableController,
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        padding: EdgeInsets.zero,
                        onPressed: (_) {},
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
                    child: AppPortfolioItem(
                      name: StringHelper.readableName(coin.symbol),
                      symbol: coin.symbol.toUpperCase().replaceAll("USDT", ""),
                      amount: "\$${coin.formattedPrice}",
                      percentChange: coin.formattedPercent,
                      iconPath: CoinIconMapper.fromSymbol(coin.symbol),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: favoriteProvider.favoriteCoins.length,
            );
          },
        ),
      ),
    );
  }
}
