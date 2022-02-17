import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get button;
  TextStyle get title;
  TextStyle get titleImages;
  TextStyle get titleContainers;
  TextStyle get titlePontos;
  TextStyle get titleNome;
  TextStyle get titleImageNaoEncontrada;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get button => GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppTheme.colors.button);

  @override
  TextStyle get title => GoogleFonts.montserrat(
      fontSize: 40, color: AppTheme.colors.title, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleImages => GoogleFonts.montserrat(
      fontSize: 12,
      color: AppTheme.colors.titleImages,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleContainers => GoogleFonts.montserrat(
      fontSize: 20,
      color: AppTheme.colors.titleImages,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titlePontos => GoogleFonts.montserrat(
      fontSize: 40, color: AppTheme.colors.title, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleNome => GoogleFonts.montserrat(
      fontSize: 14, color: AppTheme.colors.title, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleImageNaoEncontrada => GoogleFonts.montserrat(
      fontSize: 12, color: Colors.black, fontWeight: FontWeight.w700);
}
