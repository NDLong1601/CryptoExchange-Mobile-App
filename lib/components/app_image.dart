import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? width;
  final double? height;

  const AppImage({
    required this.imagePath,
    super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    /// png image ( end with .png, .jpg, .jpeg, etc ) -> use Image.asset
    /// svg image ( end with .svg ) -> use SvgPicture.asset
    /// network image ( start with http or https ) -> use Image.network
    return const Placeholder();
  }
}
