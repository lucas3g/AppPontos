import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/register/register_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  @observable
  UserModel user = UserModel();

  @observable
  RegisterStatus status = RegisterStatus.empty;

  @observable
  GlobalKey<FormState> keyNome = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyCpf = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyCelular = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyPlaca = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyEmail = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keySenha = GlobalKey<FormState>();

  @action
  void copyWith({
    String? nome,
    String? email,
    String? senha,
    String? cpf,
    String? celular,
    String? placa,
    String? uf,
    String? municipio,
    String? rua,
    String? numero,
    String? bairro,
    String? complemento,
    String? cep,
  }) {
    user = user.copyWith(
      nome: nome,
      email: email,
      senha: senha,
      cpf: cpf,
      celular: celular,
      placa: placa,
      uf: uf,
      municipio: municipio,
      rua: rua,
      numero: numero,
      bairro: bairro,
      complemento: complemento,
      cep: cep,
    );
  }

  @action
  Future<void> registerUser({required UserModel user}) async {
    await GlobalSettings().appSetting.setUser(user: user);
  }
}
