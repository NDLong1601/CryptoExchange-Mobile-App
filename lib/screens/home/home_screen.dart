import 'package:cryptoexchange_mobile_app/components/app_bottom_navigation_bar.dart';
import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/components/app_top_bar.dart';
import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoidCallback? onLeftPressed = null;

  final List<Map<String, String>> marketMovers = [
    {
      'symbol': 'BTC/USD',
      'price': '30,113.80',
      'percent': '+2.76%',
      'volume': '394 897 432,26',
      'icon': AppAssetsPath.bitcoin,
      'chart': AppAssetsPath.graph2,
    },
    {
      'symbol': 'SOL/USD',
      'price': '40,11',
      'percent': '+3.75%',
      'volume': '150 897 932,26',
      'icon': AppAssetsPath.solana,
      'chart': AppAssetsPath.graph3,
    },
    {
      'symbol': 'ETH/USD',
      'price': '1,870.10',
      'percent': '-0.76%',
      'volume': '294 897 432,26',
      'icon': AppAssetsPath.ethereum,
      'chart': AppAssetsPath.graph2,
    },
  ];
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
                  style: AppTextstyle.mediumTs16Black,
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
              SizedBox(
                height: 172,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: marketMovers.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final m = marketMovers[index];
                    return MarketMoverItem(
                      symbol: m['symbol']!,
                      price: m['price']!,
                      percentChange: m['percent']!,
                      volume: m['volume']!,
                      iconPath: m['icon']!,
                      chartPath: m['chart']!,
                    );
                  },
                ),
              ),
              AppSection(title: 'Portfolio', routeName: AppRoute.market),
              AppPortfolioItem(
                name: 'Bitcoin',
                symbol: 'BTC',
                amount: '\$1,270.10',
                percentChange: '+2.76%',
                iconPath: AppAssetsPath.bitcoin,
                onTap: () {},
              ),
              AppPortfolioItem(
                name: 'Ethereum',
                symbol: 'ETH',
                amount: '\$270.10',
                percentChange: '-1.76%',
                iconPath: AppAssetsPath.ethereum,
              ),
              AppPortfolioItem(
                name: 'Solana',
                symbol: 'ETH',
                amount: '\$1,270.10',
                percentChange: '-1.76%',
                iconPath: AppAssetsPath.solana,
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
}
