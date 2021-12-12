import 'package:get_it/get_it.dart';
import 'package:sigma_assigment/app/store/grocer_store.dart';
import 'package:sigma_assigment/app/store/login_store.dart';
import 'package:sigma_assigment/app/store/user_store.dart';
import 'package:sigma_assigment/core/services/http_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<LoginStore>(LoginStore());
  locator.registerSingleton<UserStore>(UserStore());
  locator.registerSingleton<GrocerStore>(GrocerStore());
  locator.registerSingleton<HttpService>(HttpService());
}
