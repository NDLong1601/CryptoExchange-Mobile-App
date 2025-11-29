import 'package:cryptoexchange_mobile_app/core/enum/enum.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;

  final String? leftIcon;
  final String? rightIcon;

  final double height;
  final double? width;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  final double radius;
  final double borderWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.type,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.height = 52,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.radius = 12,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = type == AppButtonType.disabled;

    // --- Style default theo type ---
    Color bg = backgroundColor ??
        (type == AppButtonType.primary
            ? const Color(0xFF2D63E2)
            : type == AppButtonType.secondary
                ? Colors.white
                : Colors.grey.shade300);

    Color txtColor = textColor ??
        (type == AppButtonType.primary
            ? Colors.white
            : type == AppButtonType.secondary
                ? const Color(0xFF2D63E2)
                : Colors.grey);

    Color brColor = borderColor ??
        (type == AppButtonType.secondary
            ? const Color(0xFF2D63E2)
            : Colors.transparent);

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: bg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: brColor, width: borderWidth),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(leftIcon!, width: 20, height: 20),
              ),

            Text(
              text,
              style: TextStyle(fontSize: 16, color: txtColor),
            ),

            if (rightIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(rightIcon!, width: 20, height: 20),
              ),
          ],
        ),
      ),
    );
  }
}
