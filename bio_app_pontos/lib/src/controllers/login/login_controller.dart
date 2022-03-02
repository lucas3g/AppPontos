import 'dart:convert';
import 'dart:io';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/dashboard_page.dart';
import 'package:bio_app_pontos/src/services/dio.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:page_transition/page_transition.dart';
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
  Future<void> acessarApp(
      {required BuildContext context, UserModel? user}) async {
    try {
      status = LoginStatus.loading;

      if (user != null) {
        cpf = user.cpf!;
        password = user.senha!;
      }

      if (!UtilBrasilFields.isCPFValido(cpf)) {
        status = LoginStatus.invalidCPF;
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Você digitou um CPF inválido.',
            type: TypeToast.dadosInv,
            context: context);
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
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Parece que você está sem Internet',
            type: TypeToast.noNet,
            context: context);
        return;
      }

      final authConfig = jsonEncode({
        "USUARIO": cpf.replaceAll('.', '').replaceAll('-', '').trim(),
        "SENHA": password.trim()
      });

      final result = await InternetAddress.lookup(MeuDio.baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await MeuDio.dio().post(
          '/login/${Constants.cnpj}/${cpf.replaceAll('.', '').replaceAll('-', '')}',
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
              title: 'Ops... :(',
              message: 'Não Foi Possivel Fazer Login.Verifique seus Dados.',
              type: TypeToast.error,
              context: context);
        }
      }
    } catch (e) {
      print('EU SOU O ERRO DE LOGIN $e');
      status = LoginStatus.error;
      MeuToast.toast(
          title: 'Ops... :(',
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
