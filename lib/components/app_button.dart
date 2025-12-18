import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:cryptoexchange_mobile_app/core/utils/format_helpper.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;

  final String? prefixIconPath;
  final String? suffixIconPath;

  final double? height;
  final double? width;

  final double radius;
  final double borderWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.type,
    this.onPressed,
    this.prefixIconPath,
    this.suffixIconPath,
    this.height,
    this.width,
    this.radius = 12,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;

    late final Color backgroundColor;
    late final Color textColor;
    late final Color borderColor;

    switch (type) {
      case AppButtonType.primary:
        backgroundColor = primary;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;

      case AppButtonType.secondary:
        backgroundColor = Colors.transparent;
        textColor = primary;
        borderColor = primary;
        break;

      case AppButtonType.disabled:
        backgroundColor = context.theme.disabledColor.withValues(alpha: 0.15);
        textColor = context.theme.disabledColor;
        borderColor = Colors.transparent;
        break;
    }

    final bool isDisabled = type == AppButtonType.disabled;

    return SizedBox(
      height: height ?? 52 / 812 * context.sh,
      width: width ?? 343 / 375 * context.sw,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: textColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  prefixIconPath!,
                  width: 20,
                  height: 20,
                  color: textColor,
                ),
              ),
            Text(
              FormatHelper.ellipsis(text, maxLength: 18),
              maxLines: 1,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            if (suffixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  suffixIconPath!,
                  width: 20,
                  height: 20,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
