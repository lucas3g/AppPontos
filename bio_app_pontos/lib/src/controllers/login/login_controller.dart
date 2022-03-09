import 'dart:convert';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/dashboard_page.dart';
import 'package:bio_app_pontos/src/repositories/check_internent_cpf.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:page_transition/page_transition.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase extends CheckInternetCPF with Store {
  @observable
  late String cpf = '';

  @observable
  late String password = '';

  @observable
  LoginStatus status = LoginStatus.empty;

  @action
  Future<void> acessarApp(
      {required BuildContext context, UserModel? user}) async {
    try {
      status = LoginStatus.loading;

      if (user != null) {
        cpf = user.cpf!;
        password = user.senha!;
      }

      if (!checkCPFService.validateCPF(cpf: cpf)) {
        status = LoginStatus.invalidCPF;
        MeuToast.toast(
            title: 'Atenção',
            message: 'Você digitou um CPF inválido.',
            type: TypeToast.dadosInv,
            context: context);
        return;
      }

      if (!(await checkInternetService.haveInternet())) {
        status = LoginStatus.semInternet;
        MeuToast.toast(
            title: 'Atenção',
            message: 'Parece que você está sem Internet',
            type: TypeToast.noNet,
            context: context);
        return;
      }

      final authConfig = jsonEncode({
        "USUARIO": cpf.replaceAll('.', '').replaceAll('-', '').trim(),
        "SENHA": password.trim()
      });

      if (await checkInternetService.haveInternet()) {
        final response = await http.post(
          Uri.parse(
              '${Constants.baseUrl}/login/${Constants.cnpj}/${cpf.replaceAll('.', '').replaceAll('-', '')}'),
          body: authConfig,
        );
        await Future.delayed(Duration(milliseconds: 600));
        if (response.statusCode == 200) {
          await GlobalSettings().appSetting.setUser(
                user: UserModel(
                  nome: jsonDecode(response.body)['nome'],
                  email: jsonDecode(response.body)['email'],
                  senha: jsonDecode(response.body)['senha'],
                  cpf: jsonDecode(response.body)['cpf'],
                  celular: jsonDecode(response.body)['celular'],
                  placa: jsonDecode(response.body)['placa'],
                  uf: jsonDecode(response.body)['uf'],
                  municipio: jsonDecode(response.body)['municipio'],
                  rua: jsonDecode(response.body)['rua'],
                  numero: jsonDecode(response.body)['numero'],
                  bairro: jsonDecode(response.body)['bairro'],
                  complemento: jsonDecode(response.body)['complemento'],
                  cep: jsonDecode(response.body)['cep'],
                ),
              );
          await GlobalSettings().appSetting.setLogado(conectado: 'S');
          status = LoginStatus.success;
          if (user == null) {
            await Future.delayed(Duration(seconds: 1));
          }
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: DashBoardPage(),
              type: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
            ),
            (route) => false,
          );
        } else {
          status = LoginStatus.error;
          MeuToast.toast(
              title: 'Atenção',
              message: 'Não Foi Possivel Fazer Login.Verifique seus Dados.',
              type: TypeToast.error,
              context: context);
        }
      }
    } catch (e) {
      print('EU SOU O ERRO DE LOGIN $e');
      status = LoginStatus.error;
      MeuToast.toast(
          title: 'Atenção',
          message: 'Não Foi Possivel Fazer Login.Verifique seus Dados.',
          type: TypeToast.error,
          context: context);
    }
  }

  @action
  Future<void> deslogar() async {
    GlobalSettings().appSetting.removeLogado();
    status = LoginStatus.empty;
  }
}
