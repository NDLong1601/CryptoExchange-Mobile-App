import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AppSlidableAction extends StatefulWidget {
  final String label;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback onPressed;

  final bool isDisabled;
  final BorderRadius? borderRadius;
  final double width;

  const AppSlidableAction({
    super.key,
    required this.label,
    required this.iconPath,
    required this.backgroundColor,
    required this.onPressed,
    this.isDisabled = false,
    this.borderRadius,
    this.width = 72,
  });

  @override
  State<AppSlidableAction> createState() => _AppSlidableActionState();
}

class _AppSlidableActionState extends State<AppSlidableAction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.94,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor =
        widget.isDisabled ? context.theme.disabledColor : Colors.white;

    final bgColor = widget.isDisabled
        ? widget.backgroundColor.withValues(alpha: 0.4)
        : widget.backgroundColor;

    return CustomSlidableAction(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      onPressed: widget.isDisabled ? null : (_) => widget.onPressed(),
      child: ClipRRect(
        borderRadius:
            widget.borderRadius ??
            const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
        child: InkWell(
          onHighlightChanged: (isDown) {
            if (isDown) {
              _scaleCtrl.reverse();
            } else {
              _scaleCtrl.forward();
            }
          },
          splashColor: Colors.white.withValues(alpha: 0.12),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: ScaleTransition(
            scale: _scaleCtrl,
            child: Container(
              width: widget.width,
              color: bgColor,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.iconPath,
                    width: 22,
                    height: 22,
                    color: iconColor,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
