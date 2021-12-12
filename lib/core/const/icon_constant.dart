import 'package:sigma_assigment/core/config/path_config.dart';

class IconConstant {
  static IconConstant? _instance;
  static IconConstant get instance => _instance ??= IconConstant._initialize();

  final String _asset = "assets/svg";

  final String logo = PathConfig.svgPath + "logo.svg";

  IconConstant._initialize();
}
