import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helpper.dart';
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
        // Coin coinSelected = coinProvider.coinSelected;
        Coin coinSelected = coinProvider.coins.firstWhere(
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
          onTap: () {
            /// show botom sheet to select coin from list coins
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SizedBox(
                  height: context.sh * 0.75,

                  /// TODO: improve UI of bottom sheet
                  /// Implement check icon for selected coin
                  child: Consumer<CoinProvider>(
                    builder: (_, coinProvider, _) {
                      return ListView.builder(
                        itemCount: coinProvider.coins.length,
                        itemBuilder: (context, index) {
                          final coin = coinProvider.coins[index];
                          return ListTile(
                            title: Text(
                              coin.symbol.toUpperCase(),
                              style: context.theme.textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              'Price: ${FormatHelper.price(coin.price)} ≈\$${FormatHelper.approxUsd(coin.price)}',
                              style: context.theme.textTheme.bodySmall,
                            ),
                            onTap: () {
                              coinProvider.selectCoinBySymbol(coin.symbol);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
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
                      style: AppTextstyle.regular16(
                        context,
                      ).copyWith(color: percentColor),
                    ),
                    TextSpan(
                      text: ' ≈\$${FormatHelper.approxUsd(coinSelected.price)}',
                      style: AppTextstyle.regular14Grey(context),
                    ),
                    TextSpan(
                      text: FormatHelper.percent(
                        coinSelected.priceChangePercent,
                      ),
                      style: AppTextstyle.regular14(
                        context,
                      ).copyWith(color: percentColor),
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
}
