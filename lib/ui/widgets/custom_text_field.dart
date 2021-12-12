import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';


class CustomTextFormField extends StatelessWidget {
  final String? suffixIconUrl;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final TextAlign? textAlign;

  const CustomTextFormField({
    Key? key,
    this.suffixIconUrl,
    this.hintText,
    this.labelText,
    this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction,
    this.validator,
    this.width,
    this.onTap,
    this.inputFormatters,
    this.onEditingComplete,
    this.onChanged,
    this.initialValue,
    this.focusNode,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textFormFiled = TextFormField(
      initialValue: null,
      obscuringCharacter: '●',
      focusNode: focusNode,
      
      decoration: InputDecoration(

        
     
        suffixIcon: suffixIconUrl != null
            ? Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SvgPicture.asset(
                  suffixIconUrl!,
                  height: 20,
                  width: 20,
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(maxHeight: 17, maxWidth: 30),
        hintText: hintText,
        
        
      ),
      controller: controller,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      validator: (String? val) {
        if (validator != null) {
          return validator!(val);
        }
      },
      inputFormatters: inputFormatters ?? [],
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(fontSize: 15.sp),
    );

    final _label = labelText != null
        ? CustomContentText(text: labelText!,textSize: CustomTextSize.headline3,)
        : const SizedBox.shrink();

    if (labelText == null) {
      return SizedBox(
          width: width, height: 50, child: _textFormFiled);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label,
        const SizedBox(
          height: 10,
        ),
        _textFormFiled,
      ],
    );
  }
}
