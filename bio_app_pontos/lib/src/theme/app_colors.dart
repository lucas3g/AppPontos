import 'package:flutter/material.dart';

abstract class AppColors {
  Color get backgroundSecondary;
  Color get backgroundPrimary;
  Color get title;
  Color get button;
  Color get border;
  Color get labelInput;
  Color get primaryColor;
  Color get secondaryColor;
  Color get dropDownTextColor;
  Color get titleLogin;
  Color get backGroundSplash;
  MaterialColor get primary;
}

class AppColorDefault implements AppColors {
  @override
  Color get backgroundSecondary => Color(0xFF40B38C);

  @override
  Color get title => Colors.white;

  @override
  Color get button => Color(0xFF666666);

  @override
  Color get backgroundPrimary => Color(0xFFFFFFFF);

  @override
  Color get border => Color(0xFFC2C2C2);

  @override
  Color get labelInput => Color(0xFFFFFFFF);

  @override
  Color get primaryColor => Color(0xFF96242d);

  @override
  Color get secondaryColor => Colors.white;

  @override
  Color get dropDownTextColor => Color(0xFF000000);

  @override
  Color get titleLogin => Color(0xffcf1f36);

  @override
  Color get backGroundSplash => Color(0xFFEB5757);

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
