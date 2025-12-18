import 'package:cryptoexchange_mobile_app/components/app_boxshadow.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';

class AppDisplayBox extends StatelessWidget {
  final String value;
  final String suffix;
  final double? width;
  final double height;

  const AppDisplayBox({
    super.key,
    required this.value,
    required this.suffix,
    this.width,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          AppBoxShadow.custom(
            y: 3,
            blurRadius: 4,
            opacity: 0.12,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            suffix,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
