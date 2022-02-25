import 'dart:convert';
import 'dart:io';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/services/dio.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  late String cpf = '';

  @observable
  late String password = '';

  @observable
  LoginStatus status = LoginStatus.empty;

  @action
  Future<void> acessarApp() async {
    try {
      status = LoginStatus.loading;

      if (!UtilBrasilFields.isCPFValido(cpf)) {
        status = LoginStatus.invalidCPF;
        return;
      }

      try {
        final result = await InternetAddress.lookup(MeuDio.baseUrl);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('Tem Internet');
        }
      } on SocketException catch (_) {
        print('Sem Internet Login');
        status = LoginStatus.semInternet;
        return;
      }

      final authConfig = jsonEncode({
        "USUARIO": cpf.replaceAll('.', '').replaceAll('-', '').trim(),
        "SENHA": password.trim()
      });

      final result = await InternetAddress.lookup(MeuDio.baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await MeuDio.dio().post(
          '/login/01459027/${cpf.replaceAll('.', '').replaceAll('-', '')}',
          data: authConfig,
        );

        await Future.delayed(Duration(milliseconds: 600));
        if (response.statusCode == 200) {
          await GlobalSettings().appSetting.setUser(
                user: UserModel(
                  nome: jsonDecode(response.data)['nome'],
                  email: jsonDecode(response.data)['email'],
                  senha: jsonDecode(response.data)['senha'],
                  cpf: jsonDecode(response.data)['cpf'],
                  celular: jsonDecode(response.data)['celular'],
                  placa: jsonDecode(response.data)['placa'],
                  uf: jsonDecode(response.data)['uf'],
                  municipio: jsonDecode(response.data)['municipio'],
                  rua: jsonDecode(response.data)['rua'],
                  numero: jsonDecode(response.data)['numero'],
                  bairro: jsonDecode(response.data)['bairro'],
                  complemento: jsonDecode(response.data)['complemento'],
                  cep: jsonDecode(response.data)['cep'],
                ),
              );
          await GlobalSettings().appSetting.setLogado(conectado: 'S');
          status = LoginStatus.success;
        } else {
          status = LoginStatus.error;
        }
      }
    } catch (e) {
      print('EU SOU O ERRO DE LOGIN $e');
      status = LoginStatus.error;
    }
  }
}
