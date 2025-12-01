import 'package:cryptoexchange_mobile_app/components/app_textstyle.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int maxLines;

  const AppText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? AppTextstyle.regularTs16Black,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
