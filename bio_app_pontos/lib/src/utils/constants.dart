import 'package:flutter/cupertino.dart';

class Constants {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final String cnpj = '01459027';
  static final String nomeApp = 'Bio Wahl - Cashback';
}

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  String get image_path => 'assets/images/logo.png';
}
