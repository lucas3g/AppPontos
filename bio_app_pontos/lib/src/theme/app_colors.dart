import 'package:flutter/material.dart';

abstract class AppColors {
  Color get backgroundPrimary;
  Color get button;
  Color get title;
  Color get titleImages;
  Color get titleContainers;
  Color get titlePontos;
  MaterialColor get primary;
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
  MaterialColor get primary => MaterialColor(0xffcf1f36, color);
}
