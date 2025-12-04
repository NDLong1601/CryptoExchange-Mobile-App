import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';
import 'package:cryptoexchange_mobile_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class ProfileBalanceWidget extends StatelessWidget {
  const ProfileBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.screenHeight * 8 / 812,
            bottom: context.screenHeight * 4 / 812,
          ),
          child: AppText(
            text: 'Portfolio Balance',
            style: AppTextstyle.mediumTs16Black,
          ),
        ),

        AppText(text: "\$ 2,760.23", style: AppTextstyle.semiBoldTs32Black),

        Padding(
          padding: EdgeInsets.only(
            top: context.screenHeight * 4 / 812,
            bottom: context.screenHeight * 16 / 812,
          ),
          child: AppText(
            text: '+2.60%',
            style: AppTextstyle.mediumTs16Black.copyWith(color: AppColor.green),
          ),
        ),
      ],
    );
  }
}
