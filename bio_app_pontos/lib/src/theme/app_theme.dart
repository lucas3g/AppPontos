import 'package:bio_app_pontos/src/theme/app_border_style.dart';
import 'package:bio_app_pontos/src/theme/app_colors.dart';
import 'package:bio_app_pontos/src/theme/app_gradients.dart';
import 'package:bio_app_pontos/src/theme/app_text_styles.dart';

class AppTheme {
  static AppColors get colors => AppColorDefault();
  static AppGradients get gradients => AppGradientsDefault();
  static AppTextStyles get textStyles => AppTextStylesDefault();
  static AppBorderStyle get borderStyle => AppBorderStylesDefault();
}
