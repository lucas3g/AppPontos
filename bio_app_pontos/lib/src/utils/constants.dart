import 'package:flutter/cupertino.dart';

class Constants {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final String cnpj = '01459027';
  static final String nomeApp = 'Bio Wahl - Cashback';
  static final String baseUrlGoogle = 'google.com';
  static final String baseUrl =
      'https://elinfo2.jelastic.saveincloud.net/AppCashBack';
  static final double latitude = -27.9512195; // BIO - -27.9512195
  static final double longitude = -52.9238309; // BIO - -52.9238309
  static final String tituloMarker = 'Bio Wahl Abastecedora';
  static final String idMarker = 'biowahl';
  static final String tituloEmail = 'Bio Wahl Abastecedora';
  static final String textoSairApp =
      "De toda a equipe da Abastecedora Bio Wahl, agradecemos por usar o aplicativo Bio Wahl - Cashback.";
}

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  String get image_path => 'assets/images/bio.png';
}
