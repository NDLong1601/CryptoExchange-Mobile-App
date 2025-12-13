import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/routes/app_route.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? leftRoute;
  final String? rightRoute;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const AppTopBar({
    super.key,
    this.leftRoute,
    this.rightRoute = AppRoute.settings,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 20),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (leftRoute != null && leftRoute!.isNotEmpty) {
                Navigator.pushNamed(context, leftRoute!);
              }
            },
            child: Image.asset(AppAssetsPath.profile, width: 24, height: 24),
          ),

          const Spacer(),
          Image.asset(AppAssetsPath.coinmoney, height: 22),
          const Spacer(),
          GestureDetector(
            onTap: () {
              if (rightRoute != null && rightRoute!.isNotEmpty) {
                Navigator.pushNamed(context, rightRoute!);
              }
            },
            child: Image.asset(AppAssetsPath.setting, width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
