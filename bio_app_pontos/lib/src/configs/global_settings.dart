import 'package:bio_app_pontos/src/configs/app_settings.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:get_it/get_it.dart';

class GlobalSettings {
  final registerController = GetIt.I.get<RegisterController>();
  final appSetting = GetIt.I.get<AppSettings>();

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
