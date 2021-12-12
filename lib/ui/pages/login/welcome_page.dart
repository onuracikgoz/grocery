import 'package:flutter/material.dart';
import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:sigma_assigment/core/config/app_config.dart';
import 'package:sigma_assigment/core/const/icon_constant.dart';
import 'package:sigma_assigment/core/enum/custom_size_enum.dart';
import 'package:sigma_assigment/core/services/icon_widget.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/ui/widgets/custom_flat_button.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';
import 'package:sigma_assigment/ui/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_header(), _footer()],
        ),
      ),
    ));
  }

  Column _footer() {
    return Column(
      children: [
        CustomFlatButton(
          text: 'Continue',
          onPressed: () {
            _navigationService.navigateTo('/login');
          },
          color: AppConfig.secondaryColor,
          width: 300.w,
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          width: 280.w,
          child: const CustomContentText(
            text: '©2021 Sigma. Tüm Hakları Saklıdır.',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 280.w,
          child: const CustomContentText(
            text: 'Developed By Sigma',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconWidget(
          iconPath: IconConstant.instance.logo,
          width: 150.w,
          height: 150.w,
        ),
        SizedBox(height: 40.h),
        const CustomContentText(
          text: "Grocery",
          textSize: CustomTextSize.headline1,
          isBold: false,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          width: 200.w,
          height: 50.h,
          child: const CustomContentText(
            text: 'Everything you need in your house is here',
            textSize: CustomTextSize.headline3,
            textAlign: TextAlign.center,
            isBold: false,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
