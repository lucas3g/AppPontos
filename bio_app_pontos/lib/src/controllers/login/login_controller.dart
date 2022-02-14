import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @action
  Future<void> acessarApp() async {
    await GlobalSettings().appSetting.setLogado(conectado: 'S');
  }
}
