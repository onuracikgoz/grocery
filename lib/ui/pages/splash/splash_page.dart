import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:sigma_assigment/core/const/icon_constant.dart';
import 'package:sigma_assigment/core/enum/login_state_enum.dart';
import 'package:sigma_assigment/core/services/icon_widget.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LoginStore _loginStore = locator<LoginStore>();

  final NavigationService _navigationService = locator<NavigationService>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(Duration(milliseconds: 2000),()async{

      await _loginStore.appStartPage();
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomIconWidget(iconPath: IconConstant.instance.logo,width: 100.w,height: 100.w,),),
    );
  }
}
