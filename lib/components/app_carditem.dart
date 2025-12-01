// import 'package:cryptoexchange_mobile_app/components/app_text.dart';
// import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:cryptoexchange_mobile_app/const/app_color.dart';

// class MarketMoverItem extends StatelessWidget {
//   final String symbol;
//   final String price;
//   final String percentChange;
//   final String volume;
//   final String iconPath;
//   final String chartPath;

//   const MarketMoverItem({
//     super.key,
//     required this.symbol,
//     required this.price,
//     required this.percentChange,
//     required this.volume,
//     required this.iconPath,
//     required this.chartPath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       width: 156 * screenWidth / 375,
//       height: 172 * screenHeight / 812,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.03),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   AppText(text: symbol, style: AppTextstyle.regularTs16Black),
//                   AppText(text: price, style: AppTextstyle.regularTs16Black),
//                 ],
//               ),
//               Image.asset(iconPath, height: 40, fit: BoxFit.contain),
//             ],
//           ),
//           AppText(
//             text: percentChange,
//             style: percentChange.startsWith('-')
//                 ? AppTextstyle.regularTs14Grey.copyWith(color: AppColor.red)
//                 : AppTextstyle.regularTs14Grey.copyWith(color: AppColor.green),
//           ),
//           Center(
//             child: Image.asset(chartPath, height: 36, fit: BoxFit.contain),
//           ),
//           SizedBox(height: 4 / 812 * screenHeight),
//           AppText(text: '24H Vol.', style: AppTextstyle.regularTs12Grey),
//           SizedBox(height: 4 / 812 * screenHeight),
//           AppText(text: volume, style: AppTextstyle.regularTs12Grey),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cryptoexchange_mobile_app/components/app_text.dart';
import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:cryptoexchange_mobile_app/const/app_color.dart';

class MarketMoverItem extends StatelessWidget {
  final String symbol;
  final String price;
  final String percentChange;
  final String volume;
  final String iconPath;
  final String chartPath;

  const MarketMoverItem({
    super.key,
    required this.symbol,
    required this.price,
    required this.percentChange,
    required this.volume,
    required this.iconPath,
    required this.chartPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      padding: EdgeInsets.only(top: 17, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: symbol, style: AppTextstyle.regularTs16Black),
                    const SizedBox(height: 2),
                    AppText(text: price, style: AppTextstyle.regularTs16Black),
                  ],
                ),
              ),
              Image.asset(iconPath, height: 32, width: 32),
            ],
          ),
          AppText(
            text: percentChange,
            style: AppTextstyle.regularTs14Grey.copyWith(
              color: percentChange.startsWith('-')
                  ? AppColor.red
                  : AppColor.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Center(
            child: Image.asset(chartPath, height: 28, fit: BoxFit.contain),
          ),
          SizedBox(height: 4),
          AppText(text: "24H Vol.", style: AppTextstyle.regularTs12Grey),
          SizedBox(height: 4),
          AppText(text: volume, style: AppTextstyle.regularTs12Grey),
        ],
      ),
    );
  }
}
