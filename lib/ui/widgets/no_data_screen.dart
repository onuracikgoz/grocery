import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/const/icon_constant.dart';
import 'package:sigma_assigment/core/services/icon_widget.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h,),
            CustomIconWidget(iconPath: IconConstant.instance.logo,height: 100.w,width: 100.w,color: AppConfig.secondaryColor.withOpacity(0.3),),
            SizedBox(
              height: 20.h,
            ),
            CustomContentText(
              textAlign: TextAlign.center,
              text: text,
            )
          ],
        ),
      ),
    );
  }
}
