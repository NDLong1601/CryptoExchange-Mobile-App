import 'package:cryptoexchange_mobile_app/components/app_display_box.dart';
import 'package:cryptoexchange_mobile_app/components/app_select_box.dart';
import 'package:cryptoexchange_mobile_app/components/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/components/app_button.dart';
import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';

class TradeOrderForm extends StatefulWidget {
  final String symbol;
  final String quote;
  final double? marketPrice;
  final double available;

  const TradeOrderForm({
    super.key,
    required this.symbol,
    required this.quote,
    this.marketPrice,
    required this.available,
  });

  @override
  State<TradeOrderForm> createState() => _TradeOrderFormState();
}

class _TradeOrderFormState extends State<TradeOrderForm> {
  double _sliderPercent = 0;
  late TextEditingController _priceCtrl;
  late TextEditingController _amountCtrl;
  String _orderType = 'Limit';
  String _displayAmount = '0';

  @override
  void initState() {
    super.initState();
    _priceCtrl = TextEditingController(
      text: widget.marketPrice?.toStringAsFixed(2),
    );
    _amountCtrl = TextEditingController(text: '0');
  }

  void _onSliderChanged(double v) {
    setState(() {
      _sliderPercent = v;
      final amount = widget.available * v;
      _displayAmount = amount.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSelectBox(
          value: _orderType,
          options: const ['Limit', 'Market'],
          width: 188 / 375 * context.sw,
          height: 40 / 812 * context.sh,
          onChanged: (v) {
            setState(() {
              _orderType = v;
            });
          },
        ),

        SizedBox(height: 8),
        Text(
          'Available: \n${widget.available.toStringAsFixed(0)} ${widget.quote}',
          style: theme.textTheme.bodySmall,
        ),
        SizedBox(height: 24),

        /// Price input
        AppTextField(
          controller: _priceCtrl,
          hintText: ' Price',
          suffix: widget.quote,
          width: 188 / 375 * context.sw,
          height: 40 / 812 * context.sh,
          onPlus: () {},
          onMinus: () {},
        ),

        const SizedBox(height: 12),

        /// Amount input
        AppTextField(
          controller: _amountCtrl,
          hintText: ' Amount',
          suffix: 'BTC',
          width: 188 / 375 * context.sw,
          height: 40 / 812 * context.sh,
          onPlus: () {},
          onMinus: () {},
        ),

        SizedBox(height: 16),

        /// Slider with tooltip
        SizedBox(
          height: context.sh * 60 / 812,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${(_sliderPercent * 100).round()}%',
                style: theme.textTheme.bodySmall,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 14,
                  ),
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: AppColor.primary,
                  showValueIndicator: ShowValueIndicator.onDrag,
                ),
                child: Slider(
                  value: _sliderPercent,
                  min: 0,
                  max: 1,
                  divisions: 4,
                  label: '${(_sliderPercent * 100).round()}%',
                  onChanged: _onSliderChanged,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        AppDisplayBox(
          value: _displayAmount, // ví dụ: '0'
          suffix: widget.quote, // 'USDT'
          width: 188 / 375 * context.sw,
          height: 40 / 812 * context.sh,
        ),
        SizedBox(height: 16),

        /// Buy button
        AppButton(
          text: 'Buy ${widget.symbol}',
          type: AppButtonType.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }
}
