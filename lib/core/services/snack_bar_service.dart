import 'package:flutter/material.dart';
import 'package:sigma_assigment/core/config/app_config.dart';

import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/ui/widgets/custom_text.dart';

import 'navigation_service.dart';

class Snack {
  static final NavigationService _navigationService =
      locator<NavigationService>();

  static showSnackBar({required String message}) {
    ScaffoldMessenger.of(_navigationService.navigatorKey.currentState!.context)
        .showSnackBar(SnackBar(
      content: CustomContentText(
        text: message,
        color: AppConfig.primaryColor,
      ),duration: const Duration(milliseconds: 3000),
    ));
  }
}
