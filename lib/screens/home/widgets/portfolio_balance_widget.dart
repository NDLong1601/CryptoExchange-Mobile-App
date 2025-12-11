import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class PortfolioBalanceWidget extends StatelessWidget {
  const PortfolioBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.sh * 8 / 812,
        bottom: context.sh * 4 / 812,
      ),
      child: AppText(
        text: 'Portfolio Balance',
        style: AppTextstyle.mediumTs16Black,
      ),
    );
  }
}
