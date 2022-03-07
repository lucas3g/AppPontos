import 'dart:convert';

import 'package:bio_app_pontos/src/models/email.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import 'package:bio_app_pontos/src/controllers/forgot_password/forgot_password_status.dart';
import 'package:bio_app_pontos/src/repositories/check_internent_cpf.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';

part 'forgot_password_controller.g.dart';

class ForgotPasswordController = _ForgotPasswordControllerBase
    with _$ForgotPasswordController;

abstract class _ForgotPasswordControllerBase extends CheckInternetCPF
    with Store {
  @observable
  String cpf = '';
  @observable
  String email = '';

  @observable
  ForgotPasswordStatus status = ForgotPasswordStatus.empty;

  @action
  Future<void> sendEmailPassword({required BuildContext context}) async {
    try {
      status = ForgotPasswordStatus.loading;

      if (!(await checkInternetService.haveInternet())) {
        status = ForgotPasswordStatus.empty;
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Parece que você está sem Internet',
            type: TypeToast.noNet,
            context: context);
        return;
      }

      try {
        EmailJson emailJson = EmailJson(r_nome: Constants.tituloEmail);
        final response = await http.post(
          Uri.parse(
              '${Constants.baseUrl}/EnviarEmail/${Constants.cnpj}/${cpf.replaceAll('.', '').replaceAll('-', '').trim()}'),
          body: emailJson.toJson(),
        );

        switch (jsonDecode(response.body)['status']) {
          case '200':
            await getEmailAndPassword();
            MeuToast.toast(
              title: 'Sucesso',
              message:
                  'Email enviado com as informações necessárias!\nPara: $email',
              type: TypeToast.success,
              context: context,
            );
            status = ForgotPasswordStatus.success;
            break;
          case '199':
            MeuToast.toast(
              title: 'Ops...',
              message:
                  'Não foi possível enviar o email. Tente novamente mais tarde.',
              type: TypeToast.error,
              context: context,
            );
            status = ForgotPasswordStatus.error;
            break;
          case '198':
            MeuToast.toast(
              title: 'Ops...',
              message: 'CPF não cadastrado. Verifique o CPF digitado.',
              type: TypeToast.dadosInv,
              context: context,
            );
            status = ForgotPasswordStatus.error;
            break;
          default:
        }
      } catch (e) {
        status = ForgotPasswordStatus.error;
        print(e);
      }
    } catch (e) {
      status = ForgotPasswordStatus.error;
    }
  }

  Future<void> getEmailAndPassword() async {
    try {
      final response = await http.post(
        Uri.parse(
            '${Constants.baseUrl}/getJson/${Constants.cnpj}/usuarios/${cpf.replaceAll('.', '').replaceAll('-', '')}'),
      );

      if (response.statusCode == 200 && response.body != '') {
        final emailResponse = jsonDecode(response.body)['email'];
        final index = emailResponse.indexOf('@');
        email = emailResponse.replaceRange(
            (index.toDouble() / 2).round(), index, '*' * 5);
      }
    } catch (e) {
      rethrow;
    }
  }
}
