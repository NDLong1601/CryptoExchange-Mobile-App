import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';

class AppSelectBox extends StatelessWidget {
  final String value;
  final List<String>? options;

  final double width;
  final double height;
  final VoidCallback? onTap;

  const AppSelectBox({
    super.key,
    required this.value,
    this.options,
    this.width = 80,
    this.height = 32,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.theme.dividerColor),
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
            Expanded(
              child: Text(
                value,
                style: context.theme.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: context.theme.iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
