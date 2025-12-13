import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
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

  Color _iconColor(int index) {
    return currentIndex == index ? AppColor.primary : AppColor.grey;
  }

  BottomNavigationBarItem _buildItem({
    required int index,
    required String iconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: _iconColor(index),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: IndexedStack(
        index: currentIndex,
        children: const [
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

        items: [
          _buildItem(index: 0, iconPath: AppAssetsPath.home, label: 'Home'),
          _buildItem(index: 1, iconPath: AppAssetsPath.trade, label: 'Trade'),
          _buildItem(index: 2, iconPath: AppAssetsPath.market, label: 'Market'),
          _buildItem(
            index: 3,
            iconPath: AppAssetsPath.favorites,
            label: 'Favorites',
          ),
          _buildItem(index: 4, iconPath: AppAssetsPath.wallet, label: 'Wallet'),
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
