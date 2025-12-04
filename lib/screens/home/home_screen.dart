import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_top_bar.dart';
import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extensions/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/string_helper.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/screens/home/widgets/profile_balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      context.read<CoinProvider>().startListening();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// TODO: Chang AppBarHeader to adapt every screen cases
            AppTopBar(
              leftRoute: AppRoute.home,
              rightRoute: AppRoute.settings,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            const ProfileBalanceWidget(),
            Image.asset(
              AppAssetsPath.graph1,
              width: double.infinity,
              height: context.screenHeight * 128 / 812,
              fit: BoxFit.contain,
            ),

            AppSection(
              title: 'Market Movers',
              routeName: AppRoute.market,
              margin: EdgeInsets.only(
                top: context.screenHeight * 16 / 812,
                left: context.screenWidth * 16 / 375,
                right: context.screenWidth * 16 / 375,
                bottom: context.screenHeight * 8 / 812,
              ),
            ),

            Consumer<CoinProvider>(
              builder: (context, provider, _) {
                final coins = provider.coins;

                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (coins.isEmpty) {
                  return const Center(child: Text("No market data"));
                }

                return SizedBox(
                  height: context.screenHeight * 172 / 812,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: coins.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final c = coins[index];
                      return MarketMoverItem(
                        symbol: StringHelper.formatSymbolPair(c.symbol),
                        price: c.formattedPrice,
                        percentChange: c.formattedPercent,
                        volume: c.volume,
                        iconPath: _iconForSymbol(c.symbol),
                        chartPath: AppAssetsPath.graph2,
                        percentColor: c.isPositive
                            ? AppColor.green
                            : AppColor.red,
                      );
                    },
                  ),
                );
              },
            ),
            AppSection(title: 'Portfolio', routeName: AppRoute.market),
            Consumer<CoinProvider>(
              builder: (context, provider, _) {
                final coins = provider.coins;

                /// TODO: Implement listview builder / separated
                return Column(
                  children: coins.map((c) {
                    return AppPortfolioItem(
                      name: _readableName(c.symbol),
                      symbol: c.symbol.replaceAll("USDT", ""),
                      amount: "\$${c.formattedPrice}",
                      percentChange: c.formattedPercent,
                      iconPath: _iconForSymbol(c.symbol),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  final Map<String, String> _coinIconMap = {
    "btc": AppAssetsPath.bitcoin,
    "eth": AppAssetsPath.ethereum,
    "sol": AppAssetsPath.solana,
    "ada": AppAssetsPath.cardano,
    "xrp": AppAssetsPath.xrp,
    "link": AppAssetsPath.link,
    "xlm": AppAssetsPath.stellar,
  };

  String _iconForSymbol(String rawSymbol) {
    final symbol = rawSymbol.toLowerCase();

    for (final key in _coinIconMap.keys) {
      if (symbol.contains(key)) {
        return _coinIconMap[key]!;
      }
    }
    return AppAssetsPath.coindefault;
  }

  String _readableName(String rawSymbol) {
    final symbol = rawSymbol.toLowerCase();
    if (symbol.contains("btc")) return "Bitcoin";
    if (symbol.contains("eth")) return "Ethereum";
    if (symbol.contains("sol")) return "Solana";
    if (symbol.contains("bnb")) return "BNB";
    if (symbol.contains("ada")) return "Cardano";
    if (symbol.contains("xrp")) return "XRP";
    if (symbol.contains("dot")) return "Polkadot";
    if (symbol.contains("matic")) return "Polygon";
    if (symbol.contains("doge")) return "Dogecoin";
    if (symbol.contains("avax")) return "Avalanche";
    if (symbol.contains("link")) return "Chainlink";
    if (symbol.contains("ltc")) return "Litecoin";
    if (symbol.contains("atom")) return "Cosmos";
    if (symbol.contains("near")) return "NEAR";
    if (symbol.contains("fil")) return "Filecoin";
    if (symbol.contains("uni")) return "Uniswap";
    if (symbol.contains("trx")) return "TRON";
    if (symbol.contains("xlm")) return "Stellar";
    if (symbol.contains("ape")) return "ApeCoin";
    if (symbol.contains("egld")) return "MultiversX";
    return rawSymbol.toUpperCase();
  }
}
