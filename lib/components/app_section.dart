import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final EdgeInsets defaultMargin = EdgeInsets.only(
      top: screenHeight * 8 / 812,
      left: screenWidth * 16 / 375,
      right: screenWidth * 16 / 375,
      bottom: screenHeight * 8 / 812,
    );

    return Container(
      margin: margin ?? defaultMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(text: title, style: AppTextstyle.mediumTs16Black),

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
                style: AppTextstyle.mediumTs16Primary,
              ),
            ),
        ],
      ),
    );
  }
}
