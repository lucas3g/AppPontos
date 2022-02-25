import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/configuracao/config_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'config_controller.g.dart';

class ConfigController = _ConfigControllerBase with _$ConfigController;

abstract class _ConfigControllerBase with Store {
  FocusNode fNome = FocusNode();
  FocusNode fCPF = FocusNode();
  FocusNode fCelular = FocusNode();
  FocusNode fEmail = FocusNode();
  FocusNode fPlaca = FocusNode();
  FocusNode fCEP = FocusNode();
  FocusNode fEstado = FocusNode();
  FocusNode fMun = FocusNode();
  FocusNode fRua = FocusNode();
  FocusNode fNumero = FocusNode();
  FocusNode fBairro = FocusNode();
  FocusNode fComplemento = FocusNode();

  GlobalKey<FormState> keyNome = GlobalKey<FormState>();
  GlobalKey<FormState> keyCPF = GlobalKey<FormState>();
  GlobalKey<FormState> keyCelular = GlobalKey<FormState>();
  GlobalKey<FormState> keyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> keyPlaca = GlobalKey<FormState>();
  GlobalKey<FormState> keyCEP = GlobalKey<FormState>();
  GlobalKey<FormState> keyEstado = GlobalKey<FormState>();
  GlobalKey<FormState> keyMun = GlobalKey<FormState>();
  GlobalKey<FormState> keyRua = GlobalKey<FormState>();
  GlobalKey<FormState> keyNumero = GlobalKey<FormState>();
  GlobalKey<FormState> keyBairro = GlobalKey<FormState>();
  GlobalKey<FormState> keyComplemento = GlobalKey<FormState>();

  TextEditingController nomeTextEditingController = TextEditingController();
  TextEditingController cpfTextEditingController = TextEditingController();
  TextEditingController celularTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController placaTextEditingController = TextEditingController();
  TextEditingController cepTextEditingController = TextEditingController();
  TextEditingController estadoTextEditingController = TextEditingController();
  TextEditingController munTextEditingController = TextEditingController();
  TextEditingController ruaTextEditingController = TextEditingController();
  TextEditingController numeroTextEditingController = TextEditingController();
  TextEditingController bairroTextEditingController = TextEditingController();
  TextEditingController complementoTextEditingController =
      TextEditingController();

  @observable
  ConfigStatus status = ConfigStatus.empty;

  @action
  Future<void> carregaDados() async {
    try {
      status = ConfigStatus.loading;

      await Future.delayed(Duration(milliseconds: 600));

      final UserModel user = GlobalSettings().appSetting.user;

      nomeTextEditingController.text = user.nome!;
      cpfTextEditingController.text = user.cpf!;
      celularTextEditingController.text = user.celular!;
      emailTextEditingController.text = user.email!;
      placaTextEditingController.text = user.placa!;
      cepTextEditingController.text = user.cep ?? '';
      estadoTextEditingController.text = user.uf ?? '';
      munTextEditingController.text = user.municipio ?? '';
      ruaTextEditingController.text = user.rua ?? '';
      numeroTextEditingController.text = user.numero ?? '';
      bairroTextEditingController.text = user.bairro ?? '';
      complementoTextEditingController.text = user.complemento ?? '';

      status = ConfigStatus.success;
    } catch (e) {
      status = ConfigStatus.error;
    }
  }
}
