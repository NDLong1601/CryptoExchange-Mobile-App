import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extensions/context_extension.dart';
import 'package:cryptoexchange_mobile_app/screens/favorites/favorites_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/home/home_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/market/market_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/trade/trade_screen.dart';
import 'package:cryptoexchange_mobile_app/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationTab extends StatefulWidget {
  const BottomNavigationTab({super.key});

  @override
  State<BottomNavigationTab> createState() => _BottomNavigationTabState();
}

class _BottomNavigationTabState extends State<BottomNavigationTab> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          const TradeScreen(),
          const MarketScreen(),
          const FavoritesScreen(),
          const WalletScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.grey,
        showUnselectedLabels: true,
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
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
