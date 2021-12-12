import 'dart:io';

import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> push(Widget page) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => page));
  }

  Future<dynamic> pushAndRemoveAll(String routeName) async {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<dynamic> pushAndReplace(String route) async {
    if (await canPop()) {
      return navigatorKey.currentState!.pushReplacementNamed(route);
    } else {
      navigateTo(route);
    }
  }

  Future<void> pop() async {
    if (await canPop()) {
      navigatorKey.currentState!.pop();
    } else {
      exit(0);
    }
  }

  Future<bool> canPop() async {
    return await navigatorKey.currentState!.canPop();
  }
}
