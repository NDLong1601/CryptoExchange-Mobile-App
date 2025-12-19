import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helper.dart';
import 'package:cryptoexchange_mobile_app/providers/chart_provider.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:provider/provider.dart';

class MarketMoverItem extends StatelessWidget {
  final String symbol;
  final String price;
  final String percentChange;
  final String volume;
  final String iconPath;
  final String chartPath;
  final Color percentColor;

  const MarketMoverItem({
    super.key,
    required this.symbol,
    required this.price,
    required this.percentChange,
    required this.volume,
    required this.iconPath,
    required this.chartPath,
    required this.percentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      padding: EdgeInsets.only(top: 17, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: symbol,
                      style: AppTextstyle.medium16(context),
                    ),
                    const SizedBox(height: 2),
                    AppText(text: price, style: AppTextstyle.medium16(context)),
                  ],
                ),
              ),
              Image.asset(iconPath, height: 32, width: 32),
            ],
          ),
          AppText(
            text: percentChange,
            style: AppTextstyle.regular14(
              context,
            ).copyWith(color: percentColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Center(
            child: Image.asset(chartPath, height: 28, fit: BoxFit.contain),
          ),
          SizedBox(height: 4),
          AppText(text: "24H Vol.", style: AppTextstyle.regular12Grey(context)),
          SizedBox(height: 4),
          AppText(text: volume, style: AppTextstyle.regular12Grey(context)),
        ],
      ),
    );
  }
}

class AppPortfolioItem extends StatelessWidget {
  final String name;
  final String symbol;
  final String amount;
  final String? percentChange;
  final String iconPath;
  final VoidCallback? onTap;

  const AppPortfolioItem({
    super.key,
    required this.name,
    required this.symbol,
    required this.amount,
    required this.iconPath,
    this.percentChange,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 343 / 375 * context.sw,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(iconPath, fit: BoxFit.contain),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: name, style: AppTextstyle.medium16(context)),
                    const SizedBox(height: 2),
                    AppText(
                      text: symbol,
                      style: AppTextstyle.regular14(context),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(text: amount, style: AppTextstyle.medium16(context)),
                  if (percentChange != null) ...[
                    const SizedBox(height: 2),
                    AppText(
                      text: percentChange!,
                      style: AppTextstyle.regular14(context).copyWith(
                        color: percentChange!.startsWith('-')
                            ? AppColor.red
                            : AppColor.green,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card Item
class AppCardItem extends StatelessWidget {
  final String symbol;
  final String price;
  final String percentChange;
  final String volume;
  final String chartPath;
  final String lowPrice;
  final String topPrice;

  const AppCardItem({
    super.key,
    required this.symbol,
    required this.price,
    required this.percentChange,
    required this.volume,
    required this.chartPath,
    required this.lowPrice,
    required this.topPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5, left: 10),
      height: context.sh * 76 / 812,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 0,
            color: AppColor.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.sw * 82 / 375,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // SYmbol / volumn
              children: [
                Spacer(),
                AppText(
                  text: FormatHelper.symbolPair(symbol),
                  style: context.theme.textTheme.labelLarge,
                ),
                AppText(
                  text: 'Vol $volume}',
                  style: context.theme.textTheme.bodySmall,
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(width: 15),
          SizedBox(
            width: context.sw * 93 / 375,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // graph / low pirce
              children: [
                AppText(
                  text: 'Top: ${FormatHelper.price(topPrice)}',
                  style: context.theme.textTheme.labelSmall,
                ),
                Image.asset(
                  chartPath,
                  height: context.sh * 36 / 812,
                  fit: BoxFit.cover,
                ),
                AppText(
                  text: 'Low: ${FormatHelper.price(lowPrice)}',
                  style: context.theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          // Price
          SizedBox(
            width: context.sw * 61 / 375,
            child: AppText(
              text: FormatHelper.price(price),
              style: context.theme.textTheme.bodyMedium,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: context.sw * 56 / 375,
              decoration: BoxDecoration(
                color: percentChange.startsWith('-')
                    ? AppColor.red
                    : AppColor.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AppText(
                text: FormatHelper.percent(percentChange),
                style: AppTextstyle.regular14(
                  context,
                ).copyWith(color: AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chart Item
class AppChartItem extends StatelessWidget {
  final String symbol;
  final String percentChange;

  const AppChartItem({
    super.key,
    required this.symbol,
    required this.percentChange,
  });

  @override
  Widget build(BuildContext context) {
    final chartCtrl = context.watch<ChartProvider>();
    chartCtrl.bindCoin(symbol, percentChange);

    return Image.asset(
      chartCtrl.chartOf(symbol),
      height: 36,
      fit: BoxFit.cover,
    );
  }
}
