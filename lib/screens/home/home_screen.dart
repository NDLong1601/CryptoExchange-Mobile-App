import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_top_bar.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/coin_icon_mapper.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helper.dart';
import 'package:cryptoexchange_mobile_app/core/utils/string_helper.dart';
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
        backgroundColor: context.scaffoldBackgroundColor,
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
                        final coinsIndex = coins[index];
                        return MarketMoverItem(
                          symbol: StringHelper.formatSymbolPair(
                            coinsIndex.symbol,
                          ),
                          price: FormatHelper.price(coinsIndex.currentPrice),
                          percentChange: coinsIndex.formattedPercent,
                          volume: coinsIndex.volume,
                          iconPath: CoinIconMapper.fromSymbol(
                            coinsIndex.symbol,
                          ),
                          chartPath: AppAssetsPath.graph2,
                          percentColor: coinsIndex.isPositive
                              ? AppColor.green
                              : AppColor.red,
                        );
                      },
                    ),
                  );
                },
              ),

              AppSection(title: 'Portfolio', onMore: () {}),
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
                        name: StringHelper.readableName(c.symbol),
                        symbol: c.symbol.toUpperCase().replaceAll("USDT", ""),
                        amount: "\$${c.formattedPrice}",
                        percentChange: c.formattedPercent,
                        iconPath: CoinIconMapper.fromSymbol(c.symbol),
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
}
