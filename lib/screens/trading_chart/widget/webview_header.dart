import 'package:cryptoexchange_mobile_app/components/app_card_item.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/coin_icon_mapper.dart';
import 'package:cryptoexchange_mobile_app/core/utils/string_helper.dart';
import 'package:cryptoexchange_mobile_app/models/coin.dart';
import 'package:cryptoexchange_mobile_app/providers/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebviewHeader extends StatelessWidget {
  const WebviewHeader({super.key});

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
        if (coinProvider.isLoading) {
          return Row(
            children: [
              Text(
                '${coinSelected.symbol.toUpperCase().replaceAll('USDT', '')}/USDT',
                style: context.theme.textTheme.bodyLarge,
              ),
              const SizedBox(width: 8),
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          );
        }
        return AppPortfolioItem(
          name: StringHelper.readableName(coinSelected.symbol),
          symbol: coinSelected.symbol.toUpperCase().replaceAll("USDT", ""),
          amount: "\$${coinSelected.formattedPrice}",
          percentChange: coinSelected.formattedPercent,
          iconPath: CoinIconMapper.fromSymbol(coinSelected.symbol),
        );
      },
    );
  }
}
