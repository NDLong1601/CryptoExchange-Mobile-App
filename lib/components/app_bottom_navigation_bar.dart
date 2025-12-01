import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final double screenHeight;
  final int currentIndex;

  const AppBottomNavigationBar({
    super.key,
    required this.screenHeight,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight * (78 / 812),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
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
    );
  }
}
