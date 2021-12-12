import 'package:flutter/material.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';


class CustomContentText extends StatelessWidget {
  final String text;
  final Color? color;
  final CustomTextSize? textSize;
  final Function()? onTap;
  final bool hasUnderline;
  final bool isBold;
  final double? letterSpacing;
  final TextAlign? textAlign;
  const CustomContentText({
    Key? key,
    required this.text,
    this.color,
    this.hasUnderline = false,
    this.onTap,
    this.textAlign,
    this.textSize,
    this.isBold = false,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _fontSize;

    switch (textSize) {
      case CustomTextSize.headline1:
        _fontSize = Theme.of(context).textTheme.headline1!.fontSize!;
        break;
      case CustomTextSize.headline3:
        _fontSize = Theme.of(context).textTheme.headline3!.fontSize!;
        break;
      case CustomTextSize.headline4:
        _fontSize = Theme.of(context).textTheme.headline4!.fontSize!;
        break;
      case CustomTextSize.headline5:
        _fontSize = Theme.of(context).textTheme.headline5!.fontSize!;
        break;
      case CustomTextSize.headline6:
        _fontSize = Theme.of(context).textTheme.headline5!.fontSize!;
        break;
      case CustomTextSize.bodyText1:
        _fontSize = Theme.of(context).textTheme.bodyText1!.fontSize!;
        break;
      case CustomTextSize.caption:
        _fontSize = Theme.of(context).textTheme.caption!.fontSize!;
        break;
      default:
        _fontSize = Theme.of(context).textTheme.headline4!.fontSize!;
    }

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black,
          decoration: hasUnderline ? TextDecoration.underline : null,
          fontSize: _fontSize,
          fontWeight: isBold ? FontWeight.bold : null,
          letterSpacing: letterSpacing,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
