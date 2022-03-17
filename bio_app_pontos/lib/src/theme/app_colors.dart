import 'package:flutter/material.dart';
import 'dart:core';

abstract class AppColors {
  Color get backgroundPrimary;
  Color get button;
  Color get title;
  Color get titleImages;
  Color get titleContainers;
  Color get titlePontos;
  Color get logadoComSucesso;
  MaterialColor get primary;

  final String hex = '0xff';
  final String colorFinal = '700391';
  final int hexFinal = 0;
}

class AppColorDefault implements AppColors {
  @override
  Color get button => Colors.white;

  @override
  Color get backgroundPrimary => Color(0xFFFFFFFF);

  @override
  Color get title => Color(0xffcf1f36);

  @override
  Color get titleImages => Colors.black;

  @override
  Color get titleContainers => Colors.black;

  @override
  Color get titlePontos => Color(0xffcf1f36);

  @override
  Color get logadoComSucesso => Color(0xff009342);

  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  String get hex => '0xff';

  @override
  String get colorFinal => 'cf1f36'; //009342 - PAPAGAIO - cf1f36 BIO

  @override
  int get hexFinal => int.parse('$hex$colorFinal');

  @override
  MaterialColor get primary => MaterialColor(hexFinal, color);
}
