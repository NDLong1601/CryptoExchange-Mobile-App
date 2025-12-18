import 'package:cryptoexchange_mobile_app/components/app_select_box.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helper.dart';
import 'package:cryptoexchange_mobile_app/models/order_level.dart';
import 'package:cryptoexchange_mobile_app/providers/orderbook_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeOrderBook extends StatefulWidget {
  final int limit;
  const TradeOrderBook({super.key, this.limit = 10});

  @override
  State<TradeOrderBook> createState() => _TradeOrderBookState();
}

class _TradeOrderBookState extends State<TradeOrderBook> {
  String orderBkNo = '10';
  String unit = '0.00001';
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderBookProvider>(
      builder: (_, orderBookProvider, _) {
        final asks = orderBookProvider.asks.take(widget.limit).toList();
        final bids = orderBookProvider.bids.take(widget.limit).toList();
        if (orderBookProvider.isLoading &&
            orderBookProvider.bids.isEmpty &&
            orderBookProvider.asks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
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
            // Header row: Price | Amount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Price',
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Amount',
                      textAlign: TextAlign.end,
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sell list (red)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: asks.length,
                itemBuilder: (_, i) {
                  final a = asks[i];
                  return _OrderRow(level: a, isSell: true);
                },
              ),
            ),

            const SizedBox(height: 8),

            // Buy list (green)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: bids.length,
                itemBuilder: (_, i) {
                  final b = bids[i];
                  return _OrderRow(level: b, isSell: false);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OrderRow extends StatelessWidget {
  final OrderLevel level;
  final bool isSell;

  const _OrderRow({required this.level, required this.isSell});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final color = isSell
        ? (theme.brightness == Brightness.dark
              ? const Color(0xFFFF8A8A)
              : AppColor.red)
        : (theme.brightness == Brightness.dark
              ? const Color(0xFF7CFFB2)
              : AppColor.green);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              FormatHelper.price(level.price),
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              level.amount.toStringAsFixed(4),
              textAlign: TextAlign.end,
              style: theme.textTheme.bodySmall,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
