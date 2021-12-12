

import 'package:flutter/material.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';

class BasicAppBar {
  static AppBar getAppBar(
      {Widget? leading,
      bool automaticallyImplyLeading = true,
      required String title,
      bool centerTitle = false,
      List<Widget>? actionButton,
      Function()? onTap}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      title: CustomContentText(
        text: title,
        isBold: false,
        textSize: CustomTextSize.headline1,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: 
       
        actionButton

      
    );
  }
}
