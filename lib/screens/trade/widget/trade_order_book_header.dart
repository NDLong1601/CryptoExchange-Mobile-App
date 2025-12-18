import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_select_box.dart';
import 'package:cryptoexchange_mobile_app/components/app_tab_bar.dart';

class OrderBookHeaderControls extends StatefulWidget {
  const OrderBookHeaderControls({super.key});

  @override
  State<OrderBookHeaderControls> createState() =>
      _OrderBookHeaderControlsState();
}

class _OrderBookHeaderControlsState extends State<OrderBookHeaderControls> {
  int _sideIndex = 0;
  String orderBkNo = '10';
  String unit = '0.00001';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sw - 16 * 2,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Order bk No.
          SizedBox(
            width: context.sw * 145 / 375,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      text: 'Order bk No.',
                      style: context.theme.textTheme.bodySmall,
                    ),
                    SizedBox(width: context.sw * 46 / 375),
                    AppText(
                      text: 'Unit',
                      style: context.theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSelectBox(
                      value: orderBkNo,
                      options: const ['5', '10', '20', '50'],
                      width: context.sw * 55 / 375,
                      onChanged: (v) => setState(() => orderBkNo = v),
                    ),
                    const Spacer(),
                    AppSelectBox(
                      value: unit,
                      options: ['0.00001', '0.0001', '0.001', '0.01', '0.1'],
                      width: context.sw * 80 / 375,
                      onChanged: (v) {
                        setState(() => unit = v);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),

          /// Buy / Sell
          SizedBox(
            width: context.sw * 188 / 375,
            height: context.sh * 32 / 812,
            child: AppTabBar(
              tabs: const ['Buy', 'Sell'],
              currentIndex: _sideIndex,
              onChanged: (i) {
                setState(() {
                  _sideIndex = i;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
