import 'package:flutter/material.dart';
import 'package:sigma_assigment/ui/pages/home/grocer_home_page.dart';
import 'package:sigma_assigment/ui/pages/home/user_home_page.dart';
import 'package:sigma_assigment/ui/pages/login/welcome_page.dart';
import 'package:sigma_assigment/ui/pages/login/login_page.dart';
import 'package:sigma_assigment/ui/pages/product/add_product_page.dart';
import 'package:sigma_assigment/ui/pages/product/basket_page.dart';
import 'package:sigma_assigment/ui/pages/product/purchase_history_page.dart';
import 'package:sigma_assigment/ui/pages/splash/splash_page.dart';
import 'package:sigma_assigment/ui/widgets/custom_appbar.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => SplashPage());

      case "/welcome":
        return MaterialPageRoute(builder: (context) => WelcomePage());

      case "/login":
        return MaterialPageRoute(builder: (context) => LoginPage());

      case "/grocerHome":
        return MaterialPageRoute(builder: (context) => GrocerHomePage());

      case "/userHome":
        return MaterialPageRoute(builder: (context) => UserHomePage());
      case "/addProduct":

              return MaterialPageRoute(builder: (context) => AddProduct());


      case "/basket":
        return MaterialPageRoute(builder: (context) => BasketPage());


      case "/purchaseHistory":
        return MaterialPageRoute(builder: (context) => PurchaseHistoryPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: BasicAppBar.getAppBar(title: "Error"),
              body: Center(
                child: CustomContentText(
                  text: "Page not found!",
                ),
              ),
            ));
  }
}
