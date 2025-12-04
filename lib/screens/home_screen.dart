import 'package:cryptoexchange_mobile_app/components/app_bottom_navigation_bar.dart';
import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/components/app_top_bar.dart';
import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppTopBar(
        leftRoute: AppRoute.home,
        rightRoute: AppRoute.settings,
      ),

      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 8 / 812,
                  bottom: screenHeight * 4 / 812,
                ),
                child: AppText(
                  text: 'Portfolio Balance',
                  style: AppTextstyle.mediumTs16Black,
                ),
              ),

              AppText(
                text: "\$ 2,760.23",
                style: AppTextstyle.semiBoldTs32Black,
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 4 / 812,
                  bottom: screenHeight * 16 / 812,
                ),
                child: AppText(
                  text: '+2.60%',
                  style: AppTextstyle.mediumTs16Black.copyWith(
                    color: AppColor.green,
                  ),
                ),
              ),

              Image.asset(
                AppAssetsPath.graph1,
                width: double.infinity,
                height: screenHeight * 128 / 812,
                fit: BoxFit.contain,
              ),

              AppSection(
                title: 'Market Movers',
                routeName: AppRoute.market,
                margin: EdgeInsets.only(
                  top: screenHeight * 16 / 812,
                  left: screenWidth * 16 / 375,
                  right: screenWidth * 16 / 375,
                  bottom: screenHeight * 8 / 812,
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
                    height: 172,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: coins.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final c = coins[index];
                        return MarketMoverItem(
                          symbol: _formatSymbolPair(c.symbol),
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
        ],
      ),

      bottomNavigationBar: AppBottomNavigationBar(
        screenHeight: screenHeight,
        currentIndex: 0,
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

  String _formatSymbolPair(String raw) {
    final s = raw.toUpperCase().replaceAll("USDT", "");
    return "$s/USD";
  }
}
