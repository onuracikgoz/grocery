
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomIconWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String iconPath;
  final Function()? onTap;
  final Color? color;
  const CustomIconWidget(
      {Key? key,
      required this.iconPath,
      this.color,
      this.onTap,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        child: SvgPicture.asset(iconPath, color: color),
        height: height ?? 20,
        width: width ?? 20,
      ),
    );
  }
}
