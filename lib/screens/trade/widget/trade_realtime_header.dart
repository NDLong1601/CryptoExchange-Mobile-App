import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helper.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeRealtimeHeader extends StatelessWidget {
  const TradeRealtimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
      builder: (_, coinProvider, _) {
        final Coin coinSelected = coinProvider.coins.firstWhere(
          (coin) =>
              coin.symbol.toLowerCase() ==
              coinProvider.selectedSymbol.toLowerCase(),
          orElse: () => coinProvider.defaultCoin(),
        );

        final pair =
            '${coinSelected.symbol.toUpperCase().replaceAll('USDT', '')}/USDT';

        final percent = double.tryParse(coinSelected.priceChangePercent) ?? 0;

        final percentColor = percent >= 0
            ? (context.theme.brightness == Brightness.dark
                  ? const Color(0xFF7CFFB2)
                  : AppColor.green)
            : (context.theme.brightness == Brightness.dark
                  ? const Color(0xFFFF8A8A)
                  : AppColor.red);

        if (coinProvider.isLoading) {
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

        return GestureDetector(
          onTap: () => _showCoinBottomSheet(context),
          child: Column(
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
                      text: FormatHelper.price(coinSelected.price),
                      style: AppTextstyle.regular16(context).copyWith(
                        color: percentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ${FormatHelper.approxUsd(coinSelected.price)} ',
                      style: AppTextstyle.regular14Grey(context),
                    ),
                    TextSpan(
                      text: FormatHelper.percent(
                        coinSelected.priceChangePercent,
                      ),
                      style: AppTextstyle.regular14(context).copyWith(
                        color: percentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCoinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Consumer<CoinProvider>(
          builder: (_, provider, _) {
            final theme = Theme.of(ctx);
            final selected = provider.selectedSymbol.toLowerCase();

            return Container(
              height: ctx.sh * 0.75,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Select coin',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(ctx),
                          icon: Icon(Icons.close, color: theme.iconTheme.color),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: provider.coins.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final coin = provider.coins[index];
                        final isSelected =
                            coin.symbol.toLowerCase() == selected;

                        final pct =
                            double.tryParse(coin.priceChangePercent) ?? 0;

                        final pctColor = pct >= 0
                            ? (theme.brightness == Brightness.dark
                                  ? const Color(0xFF7CFFB2)
                                  : AppColor.green)
                            : (theme.brightness == Brightness.dark
                                  ? const Color(0xFFFF8A8A)
                                  : AppColor.red);

                        final pair =
                            '${coin.symbol.toUpperCase().replaceAll('USDT', '')}/USDT';

                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            provider.selectCoinBySymbol(coin.symbol);
                            Navigator.pop(ctx);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.dividerColor.withValues(alpha: 0.5),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pair,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            'Price : \$${FormatHelper.price(coin.price)}',
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            FormatHelper.percent(
                                              coin.priceChangePercent,
                                            ),
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: pctColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 160),
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.dividerColor,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                    color: isSelected
                                        ? AppColor.white
                                        : AppColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
