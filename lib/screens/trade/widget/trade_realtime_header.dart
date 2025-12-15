import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helpper.dart';
import 'package:cryptoexchange_mobile_app/providers/trade_ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeRealtimeHeader extends StatelessWidget {
  const TradeRealtimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeTickerProvider>(
      builder: (_, p, _) {
        final pair = '${p.symbol.toUpperCase().replaceAll('USDT', '')}/USDT';

        final percent = double.tryParse(p.percent) ?? 0;
        final percentColor = percent >= 0
            ? (context.theme.brightness == Brightness.dark
                  ? const Color(0xFF7CFFB2)
                  : AppColor.green)
            : (context.theme.brightness == Brightness.dark
                  ? const Color(0xFFFF8A8A)
                  : AppColor.red);

        if (p.isLoading) {
          return Row(
            children: [
              Text(pair, style: context.theme.textTheme.bodyLarge),
              const SizedBox(width: 8),
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(pair, style: context.theme.textTheme.bodyLarge),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  color: context.theme.iconTheme.color,
                ),
              ],
            ),

            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text : FormatHelper.price(p.price),
                    style: AppTextstyle.regular16(
                      context,
                    ).copyWith(color: percentColor),
                  ),
                  TextSpan(
                    text: ' ≈\$${FormatHelper.approxUsd(p.price)}',
                    style: AppTextstyle.regular14Grey(context),
                  ),
                  TextSpan(
                    text:
                        FormatHelper.percent(p.percent),
                    style: AppTextstyle.regular14(
                      context,
                    ).copyWith(color: percentColor),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
