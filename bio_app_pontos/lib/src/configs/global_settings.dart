import 'package:bio_app_pontos/src/configs/app_settings.dart';
import 'package:bio_app_pontos/src/controllers/configuracao/config_controller.dart';
import 'package:bio_app_pontos/src/controllers/forgot_password/forgot_password_controller.dart';
import 'package:bio_app_pontos/src/controllers/historico/historico_controller.dart';
import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/maps/maps_controller.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_controller.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:get_it/get_it.dart';

class GlobalSettings {
  final appSetting = GetIt.I.get<AppSettings>();
  final registerController = GetIt.I.get<RegisterController>();
  final pontosPromocoesController = GetIt.I.get<PontosPromocoesController>();
  final historicoController = GetIt.I.get<HistoricoController>();
  final loginController = GetIt.I.get<LoginController>();
  final mapsController = GetIt.I.get<MapsController>();
  final configController = GetIt.I.get<ConfigController>();
  final forgotPasswordController = GetIt.I.get<ForgotPasswordController>();

  static recursiveFunction(
      {required Function function,
      required int quantity,
      required Function? callback}) async {
    try {
      return await function();
    } catch (err) {
      if (quantity == 3) {
        if (callback != null) {
          return await callback();
        }
        return;
      } else {
        quantity++;
        return Future.delayed(Duration(milliseconds: 200)).then((value) async {
          return await recursiveFunction(
              function: function, quantity: quantity, callback: callback);
        });
      }
    }
  }
}
