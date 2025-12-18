import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppSelectBox extends StatelessWidget {
  final String value;
  final List<String> options;
  final double width;
  final double height;
  final ValueChanged<String> onChanged;

  const AppSelectBox({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.width = 80,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        offset: Offset(0, height + 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onSelected: onChanged,
        itemBuilder: (_) {
          return options.map((e) {
            final selected = e == value;
            return PopupMenuItem<String>(
              value: e,
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (selected)
                    Icon(
                      Icons.check,
                      size: 18,
                      color: context.theme.primaryColor,
                    ),
                ],
              ),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: context.theme.cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.theme.dividerColor),
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
      ),
    );
  }
}
