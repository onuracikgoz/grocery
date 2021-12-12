import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final double? width;
  final Color? color;
  final Color? iconColor;
  final String? iconUrl;
  final List<Color>? gradientColors;
  final bool isBorder;
  final Color? textColor;
  final Function() onPressed;
  final bool isBoldText;
  const CustomFlatButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.iconUrl,
    this.width,
    this.isLoading = false,
    this.isBoldText = true,
    this.gradientColors,
    this.isBorder = false,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    final _content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconUrl != null
            ? SvgPicture.asset(
                iconUrl!,
                height: 20.h,
                color: iconColor,
              )
            : const SizedBox.shrink(),
        iconUrl != null
            ? SizedBox(
                width: 10.w,
              )
            : const SizedBox.shrink(),
        CustomContentText(
            text: text,
            color: textColor ?? themeData.colorScheme.background,
            isBold: isBoldText,textSize: CustomTextSize.headline4,),
      ],
    );

    const _loading = Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );

    return SizedBox(
      width: width,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: isBorder
              ? Border.all(
                  color: AppConfig.secondaryColor, style: BorderStyle.solid)
              : null,
          gradient: color == null
              ? LinearGradient(
                  colors: gradientColors ??
                      [AppConfig.primaryColor, AppConfig.secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp,
                  stops: const [0.5, 1.0],
                )
              : null,
          color: color ?? themeData.primaryColor,
        ),
        child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  AppConfig.secondaryColor.withOpacity(0.2))),
          onPressed: () {
            if (!isLoading) {
              onPressed();
            }
          },
          child: isLoading ? _loading : _content,
        ),
      ),
    );
  }
}
