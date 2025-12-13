import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_top_bar.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:cryptoexchange_mobile_app/screens/home/widgets/portfolio_balance_widget.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppTopBar(
          leftRoute: AppRoute.home,
          rightRoute: AppRoute.settings,
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.zero,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PortfolioBalanceWidget(),
              AppSection(
                title: 'Market Movers',
                routeName: AppRoute.market,
                margin: EdgeInsets.only(
                  top: context.sh * 16 / 812,
                  left: context.sw * 16 / 375,
                  right: context.sw * 16 / 375,
                  bottom: context.sh * 8 / 812,
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

                  if (provider.isLoading && coins.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (coins.isEmpty) {
                    return const Center(child: Text("No portfolio data"));
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.sw * 16 / 375,
                    ),
                    itemCount: coins.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final c = coins[index];

                      return AppPortfolioItem(
                        name: _readableName(c.symbol),
                        symbol: c.symbol.toUpperCase().replaceAll("USDT", ""),
                        amount: "\$${c.formattedPrice}",
                        percentChange: c.formattedPercent,
                        iconPath: _iconForSymbol(c.symbol),
                      );
                    },
                  );
                },
              ),
            ],
          ),
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
    "link": AppAssetsPath.chainlink,
    "xlm": AppAssetsPath.stellar,
    "ape": AppAssetsPath.apecoin,
    "bnb": AppAssetsPath.bnb,
    "dot": AppAssetsPath.polkadot,
    "matic": AppAssetsPath.apecoin,
    "doge": AppAssetsPath.dogecoin,
    "avax": AppAssetsPath.avalance,
    "ltc": AppAssetsPath.litecoin,
    "atom": AppAssetsPath.cosmos,
    "near": AppAssetsPath.near,
    "fil": AppAssetsPath.filecoin,
    "uni": AppAssetsPath.uniswap,
    "trx": AppAssetsPath.tron,
    "egld": AppAssetsPath.multiversx,
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
