import 'package:cryptoexchange_mobile_app/core/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  final double height;
  final double radius;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onChanged,
    this.height = 40,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = context.theme.dividerColor.withValues(alpha: 0.6);
    final mutedText = context.theme.hintColor;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = i == currentIndex;

          return Expanded(
            child: Stack(
              children: [
                if (i != 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 1,
                      height: height * 0.55,
                      color: borderColor,
                    ),
                  ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radius),
                    onTap: () => onChanged(i),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? context.colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Text(
                        tabs[i],
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: selected ? AppColor.white : mutedText,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
