import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class PortfolioBalanceWidget extends StatelessWidget {
  const PortfolioBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
        AppText(text: "\$ 2,760.23", style: AppTextstyle.semiBold32(context)),

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
  }

  /// format number to currency string
  String formatCurrency(num value, {String symbol = '\$'}) {
    final sign = value < 0 ? '-' : '';
    final absValue = value.abs().toDouble();
    final parts = absValue.toStringAsFixed(2).split('.');
    final integer = parts[0];
    final decimal = parts[1];
    final withCommas = integer.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return '$sign$symbol $withCommas.$decimal';
  }
}
