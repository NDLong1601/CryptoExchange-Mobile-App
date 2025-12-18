// lib/screens/trade/widget/open_orders_section.dart
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_assets_path.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/const/app_color.dart';
import '../../../core/extension/context_extension.dart';
import '../../../models/open_order.dart';
import '../../../providers/coin_provider.dart';
import '../../../providers/open_orders_provider.dart';

class OpenOrdersSection extends StatelessWidget {
  final VoidCallback? onMore;

  const OpenOrdersSection({super.key, this.onMore});

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<CoinProvider>().selectedSymbol.toUpperCase();

    return Consumer<OpenOrdersProvider>(
      builder: (_, p, _) {
        final orders = p.visibleOrders(selected);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: "Open Orders" + "More"
            Row(
              children: [
                Text(
                  'Open Orders',
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onMore,
                  child: Text(
                    'More',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Checkbox + Cancel all
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => p.toggleHideOtherPairs(!p.hideOtherPairs),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: p.hideOtherPairs
                              ? AppColor.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: p.hideOtherPairs
                                ? AppColor.primary
                                : AppColor.grey,
                            width: 1.5,
                          ),
                        ),
                        child: p.hideOtherPairs
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Hide Other Pairs',
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                _SmallActionButton(text: 'Cancel all', onTap: p.cancelAll),
              ],
            ),

            const SizedBox(height: 12),

            if (orders.isEmpty)
              _EmptyOpenOrdersPlaceholder(isFilterOn: p.hideOtherPairs)
            else
              ...orders.map(
                (o) =>
                    OpenOrderItem(order: o, onCancel: () => p.cancelOrder(o)),
              ),
          ],
        );
      },
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SmallActionButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 4,
              spreadRadius: 0,
              color: AppColor.black.withValues(alpha: 0.12),
            ),
          ],
        ),
        child: AppText(
          text: text,
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: context.theme.hintColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EmptyOpenOrdersPlaceholder extends StatelessWidget {
  final bool isFilterOn;

  const _EmptyOpenOrdersPlaceholder({required this.isFilterOn});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppAssetsPath.box, color: AppColor.grey)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class OpenOrderItem extends StatelessWidget {
  final OpenOrder order;
  final VoidCallback onCancel;

  const OpenOrderItem({super.key, required this.order, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final isSell = order.side == OrderSide.sell;

    final sideColor = isSell
        ? (context.theme.brightness == Brightness.dark
              ? const Color(0xFFFF8A8A)
              : AppColor.red)
        : (context.theme.brightness == Brightness.dark
              ? const Color(0xFF7CFFB2)
              : AppColor.green);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ───────────────── Header ─────────────────
          Row(
            children: [
              Text(
                order.pairDisplay,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                FormatHelper.formatTime(order.createdAt),
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.theme.hintColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// ───────────── Sell / Buy + Type ─────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: isSell ? 'Sell ' : 'Buy ',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: sideColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: order.orderType,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.theme.textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _CancelButton(onTap: onCancel),
            ],
          ),

          const SizedBox(height: 10),

          /// ───────────── Price / Filled ─────────────
          Row(
            children: [
              Expanded(
                child: _InfoItem(label: 'Price', value: order.price.toString()),
              ),
              Expanded(
                child: _InfoItem(
                  label: 'Filled',
                  value: '${(order.filledRatio * 100).toStringAsFixed(2)}%',
                  alignRight: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// ───────────── Amount / Total ─────────────
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  label: 'Amount',
                  value: order.amount.toString(),
                ),
              ),
              Expanded(
                child: _InfoItem(
                  label: 'Total',
                  value: '≈${order.total.toStringAsFixed(3)} USDT',
                  alignRight: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool alignRight;

  const _InfoItem({
    required this.label,
    required this.value,
    this.alignRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: context.theme.hintColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CancelButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Text(
          'Cancel',
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: context.theme.hintColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
