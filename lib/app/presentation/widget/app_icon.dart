import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.color,
    required this.width,
    required this.height,
  });

  const AppIcon.square(
    this.icon, {
    super.key,
    required this.color,
    required double size,
  })  : width = size,
        height = size;

  final String icon;
  final Color? color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: width,
      height: height,
      color: color,
    );
  }
}
