import 'package:cryptoexchange_mobile_app/components/app_carditem.dart';
import 'package:cryptoexchange_mobile_app/components/app_section.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
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
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '');
                },
                child: Image.asset(
                  AppAssetsPath.profile,
                  width: 24,
                  height: 24,
                ),
              ),
              const Spacer(),
              Image.asset(AppAssetsPath.coinmoney, height: 22),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.settings);
                },
                child: Image.asset(
                  AppAssetsPath.setting,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
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
              AppSection(title: 'Market Movers', routeName: AppRoute.market),
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: screenHeight * (78 / 812),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(AppAssetsPath.home, width: 24, height: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssetsPath.trade, width: 24, height: 24),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssetsPath.market, width: 24, height: 24),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssetsPath.favorites, width: 24, height: 24),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssetsPath.wallet, width: 24, height: 24),
              label: 'Wallet',
            ),
          ],
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, AppRoute.home);
                break;
              case 1:
                Navigator.pushNamed(context, AppRoute.trade);
                break;
              case 2:
                Navigator.pushNamed(context, AppRoute.market);
                break;
              case 3:
                Navigator.pushNamed(context, AppRoute.favorite);
                break;
              case 4:
                Navigator.pushNamed(context, AppRoute.wallet);
                break;
            }
          },
        ),
      ),
    );
  }
}
