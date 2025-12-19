import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PortfolioBalanceWidget extends StatelessWidget {
  const PortfolioBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
      builder: (context, provider, _) {
        final coins = provider.coins;

        if (provider.isLoading && coins.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (coins.isEmpty) {
          return const Center(child: Text("No portfolio data"));
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: context.sh * 8 / 812,
                bottom: context.sh * 4 / 812,
              ),
              child: AppText(
                text: 'Portfolio Balance',
                style: AppTextstyle.medium16(context),
              ),
            ),
            AppText(
              text: "\$ 2,760.23",
              style: AppTextstyle.semiBold32(context),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: context.sh * 4 / 812,
                bottom: context.sw * 16 / 812,
              ),
              child: AppText(
                text: '+2.60%',
                style: AppTextstyle.medium16Green(context),
              ),
            ),

            Image.asset(
              AppAssetsPath.graph1,
              width: double.infinity,
              height: context.sh * 128 / 812,
              fit: BoxFit.contain,
            ),
          ],
        );
      },
    );
  }
}
