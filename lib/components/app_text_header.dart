import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppTextHeader extends StatelessWidget {
  const AppTextHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: 'Pair\nUSDT',
            maxLines: 2,
            style: context.theme.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          SizedBox(width: context.sw * 110 / 375),
          AppText(
            text: 'Last\nPrice',
            maxLines: 2,
            style: context.theme.textTheme.bodyMedium,
          ),
          AppText(
            text: '24h\nTrade',
            maxLines: 2,
            style: context.theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
