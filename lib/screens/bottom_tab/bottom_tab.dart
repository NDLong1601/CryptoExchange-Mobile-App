import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/screens/favorites/favorites_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/home/home_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/market/market_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/trade_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(),
          TradeScreen(),
          MarketScreen(),
          FavoritesScreen(),
          WalletScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.grey,
        showUnselectedLabels: true,

        /// TODO: Adjust icon , text color based on selected tab
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
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
