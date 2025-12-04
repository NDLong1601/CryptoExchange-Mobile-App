import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
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
                    AppText(text: symbol, style: AppTextstyle.regularTs16Black),
                    const SizedBox(height: 2),
                    AppText(text: price, style: AppTextstyle.regularTs16Black),
                  ],
                ),
              ),
              Image.asset(iconPath, height: 32, width: 32),
            ],
          ),
          AppText(
            text: percentChange,
            style: AppTextstyle.regularTs14Grey.copyWith(
              color: percentChange.startsWith('-')
                  ? AppColor.red
                  : AppColor.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Center(
            child: Image.asset(chartPath, height: 28, fit: BoxFit.contain),
          ),
          SizedBox(height: 4),
          AppText(text: "24H Vol.", style: AppTextstyle.regularTs12Grey),
          SizedBox(height: 4),
          AppText(text: volume, style: AppTextstyle.regularTs12Grey),
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
          width: 343 / 375 * MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
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
                    AppText(text: name, style: AppTextstyle.mediumTs16Black),
                    const SizedBox(height: 2),
                    AppText(text: symbol, style: AppTextstyle.regularTs14Grey),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(text: amount, style: AppTextstyle.mediumTs16Black),
                  if (percentChange != null) ...[
                    const SizedBox(height: 2),
                    AppText(
                      text: percentChange!,
                      style: AppTextstyle.regularTs14Grey.copyWith(
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
