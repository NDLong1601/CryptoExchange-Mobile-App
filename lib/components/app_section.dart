import 'package:cryptoexchange_mobile_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';

/// Section Home
class AppSection extends StatelessWidget {
  final String title;
  final bool showMore;
  final VoidCallback? onMore;
  final String? routeName;
  final EdgeInsets? margin;

  const AppSection({
    super.key,
    required this.title,
    this.showMore = true,
    this.onMore,
    this.routeName,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final EdgeInsets defaultMargin = EdgeInsets.only(
      top: context.sh * 8 / 812,
      left: context.sw * 16 / 375,
      right: context.sw * 16 / 375,
      bottom: context.sh * 8 / 812,
    );

    return Container(
      margin: margin ?? defaultMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: title, style: AppTextstyle.medium16(context)),

          if (showMore)
            GestureDetector(
              onTap: () {
                if (routeName != null) {
                  Navigator.pushNamed(context, routeName!);
                } else if (onMore != null) {
                  onMore!();
                }
              },
              child: AppText(
                text: 'More',
                style: AppTextstyle.medium16Primary(context),
              ),
            ),
        ],
      ),
    );
  }
}

/// Section Setting
class AppSectionHeader extends StatelessWidget {
  final String title;

  const AppSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: (33 / 375) * context.sw,
        bottom: 8,
      ),

      child: AppText(
        text: title,
        style: AppTextstyle.medium16(context),
        textAlign: TextAlign.start,
      ),
    );
  }
}
