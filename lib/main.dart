import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sigma_assigment/core/services/generate_route.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';
import 'package:sigma_assigment/core/theme/theme.dart';
import 'package:sigma_assigment/ui/pages/login/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sigma_assigment/ui/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MaterialApp(
              navigatorKey: locator<NavigationService>().navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: AppTheme.getThemeFromThemeMode(),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: "/",
            ));
  }
}
