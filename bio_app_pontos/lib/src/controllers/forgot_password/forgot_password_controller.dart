import 'dart:convert';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/forgot_password/forgot_password_status.dart';
import 'package:bio_app_pontos/src/services/dio.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordControllerBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordControllerBase with Store {
  @observable
  String cpf = '';
  String email = '';
  String password = '';

  @observable
  ForgotPasswordStatus status = ForgotPasswordStatus.empty;

  @action
  Future<void> sendEmailPassword({required BuildContext context}) async {
    try {
      status = ForgotPasswordStatus.loading;
      final controllerCpf = GlobalSettings().registerController;

      if (await controllerCpf.verificaCPFCadastrado(cpf: cpf)) {
        await Future.delayed(Duration(seconds: 5));
        if (await getEmailAndPassword()) {
          MeuToast.toast(
            title: 'Sucesso',
            message:
                'Email enviado com as informações necessárias!\nPara: $email',
            type: TypeToast.success,
            context: context,
          );
          password = '';
          email = '';
          cpf = '';
        }
      } else {
        MeuToast.toast(
          title: 'Ops...',
          message: 'CPF não encontrado, verifique o CPF digitado.',
          type: TypeToast.dadosInv,
          context: context,
        );
      }

      status = ForgotPasswordStatus.success;
    } catch (e) {
      status = ForgotPasswordStatus.error;
    }
  }

  Future<bool> getEmailAndPassword() async {
    try {
      final response = await MeuDio.dio().post(
        '/getJson/${Constants.cnpj}/usuarios/${cpf.replaceAll('.', '').replaceAll('-', '')}',
      );

      if (response.statusCode == 200 && response.data != '') {
        final emailResponse = jsonDecode(response.data)['email'];
        final index = emailResponse.indexOf('@');
        email = emailResponse.replaceRange(
            (index.toDouble() / 2).round(), index, '*' * 5);
        password = jsonDecode(response.data)['senha'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
