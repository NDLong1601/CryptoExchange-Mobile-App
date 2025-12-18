import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_select_box.dart';
import 'package:cryptoexchange_mobile_app/components/app_tab_bar.dart';

class OrderBookHeaderControls extends StatelessWidget {
  const OrderBookHeaderControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Order bk No.
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText(
                  text: 'Order bk No.',
                  style: context.theme.textTheme.bodySmall,
                ),
                SizedBox(width: context.sw * 46 / 375),
                AppText(text: 'Unit', style: context.theme.textTheme.bodySmall),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppSelectBox(
                  value: '10',
                  options: ['5', '10', '20', '50'],
                  width: context.sw * 55 / 375,
                ),

                AppSelectBox(
                  value: '0.00001',
                  options: ['0.00001', '0.0001', '0.001'],
                  width: context.sw * 80 / 375,
                ),
              ],
            ),
          ],
        ),

        /// Buy / Sell
        SizedBox(
          width: context.sw * 188 / 375,
          height: context.sh * 32 / 812,
          child: AppTabBar(
            tabs: ['Buy', 'Sell'],
            currentIndex: 0,
            onChanged: (_) {},
            height: 32,
            radius: 8,
          ),
        ),
      ],
    );
  }
}
