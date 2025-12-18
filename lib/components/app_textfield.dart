import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String suffix;

  final double? width;
  final double height;

  final VoidCallback? onPlus;
  final VoidCallback? onMinus;

  final bool enablePlus;
  final bool enableMinus;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.suffix,
    this.width,
    this.height = 40,
    this.onPlus,
    this.onMinus,
    this.enablePlus = true,
    this.enableMinus = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
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
          /// Minus
          _IconButton(icon: Icons.remove, enabled: enableMinus, onTap: onMinus),

          /// Input
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: theme.textTheme.bodyMedium,
            ),
          ),

          /// Suffix
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              suffix,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// Plus
          _IconButton(icon: Icons.add, enabled: enablePlus, onTap: onPlus),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;

  const _IconButton({required this.icon, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final color = enabled
        ? context.theme.iconTheme.color
        : context.theme.disabledColor;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
