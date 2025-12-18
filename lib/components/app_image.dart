import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? width;
  final double? height;

  const AppImage({
    super.key,
    required this.imagePath,
    this.color,
    this.width,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        color: color,
      );
    } else if (imagePath.endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    } else {
      return Image.asset(imagePath, width: width, height: height, color: color);
    }
  }
}
