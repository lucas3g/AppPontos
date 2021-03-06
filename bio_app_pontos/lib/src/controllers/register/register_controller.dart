import 'dart:convert';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/register/register_status.dart';
import 'package:bio_app_pontos/src/controllers/register/register_status_cep.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/repositories/check_internent_cpf.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase extends CheckInternetCPF with Store {
  final loginController = LoginController();

  @observable
  UserModel user = UserModel();

  @observable
  RegisterStatus status = RegisterStatus.empty;

  @observable
  RegisterStatusCep statusCep = RegisterStatusCep.empty;

  @observable
  late bool aceitouTermos = false;

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
  @observable
  GlobalKey<FormState> keyCep = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyEstado = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyMunicipio = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyRua = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyBairro = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyNumero = GlobalKey<FormState>();
  @observable
  GlobalKey<FormState> keyComplemento = GlobalKey<FormState>();

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
  Future<bool> registerUser({required BuildContext context}) async {
    try {
      if (!aceitouTermos) {
        MeuToast.toast(
          title: 'Aten????o',
          message: 'Para continuar voc?? deve aceitar os termos de uso',
          type: TypeToast.dadosInv,
          context: context,
        );

        return false;
      }

      status = RegisterStatus.loading;
      await Future.delayed(Duration(seconds: 1));

      if (await checkInternetService.haveInternet()) {
        if (await verificaCPFCadastrado()) {
          status = RegisterStatus.cnpjJaCadastrado;
          return false;
        }
        final response = await http.post(
          Uri.parse(
              '${Constants.baseUrl}/setJson/${Constants.cnpj}/usuarios/${user.cpf!.replaceAll('.', '').replaceAll('-', '')}'),
          body: user.toJson(),
        );

        if (response.statusCode == 200) {
          await GlobalSettings().appSetting.setUser(user: user);
          status = RegisterStatus.success;
          await Future.delayed(Duration(seconds: 1));
          await loginController.acessarApp(context: context, user: user);
          status = RegisterStatus.empty;
          return true;
        } else {
          MeuToast.toast(
            title: 'Aten????o',
            message:
                'N??o foi poss??vel concluir o seu cadastro, por favor tente novamente.',
            type: TypeToast.error,
            context: context,
          );
          status = RegisterStatus.error;
          return false;
        }
      } else {
        MeuToast.toast(
          title: 'Aten????o',
          message: 'Parece que voc?? esta sem internet, por favor verifique.',
          type: TypeToast.noNet,
          context: context,
        );
        return false;
      }
    } catch (e) {
      MeuToast.toast(
        title: 'Aten????o',
        message:
            'N??o foi poss??vel concluir o seu cadastro, por favor tente novamente.',
        type: TypeToast.error,
        context: context,
      );
      status = RegisterStatus.error;
      return false;
    }
  }

  @action
  Future<List<String>> buscaCEP(
      {required String cep, required BuildContext cxt}) async {
    try {
      statusCep = RegisterStatusCep.loading;
      if (!(await checkInternetService.haveInternet())) {
        statusCep = RegisterStatusCep.empty;
        MeuToast.toast(
          title: 'Aten????o',
          message: 'Parece que voc?? est?? sem Internet',
          type: TypeToast.noNet,
          context: cxt,
        );
        return [];
      } else {
        final List<String> lista = [];
        final cepSemCaracter = cep.replaceAll('.', '').replaceAll('-', '');
        final response = await http.get(
          Uri.parse('https://viacep.com.br/ws/$cepSemCaracter/json/'),
        );

        switch (jsonDecode(response.body)['uf']) {
          case 'AC':
            lista.add('Acre');
            break;
          case 'AL':
            lista.add('Alagoas');
            break;
          case 'AP':
            lista.add('Amap??');
            break;
          case 'AM':
            lista.add('Amazonas');
            break;
          case 'BA':
            lista.add('Bahia');
            break;
          case 'CE':
            lista.add('Cear??');
            break;
          case 'ES':
            lista.add('Esp??rito Santo');
            break;
          case 'GO':
            lista.add('Goi??s');
            break;
          case 'MA':
            lista.add('Maranh??o');
            break;
          case 'MT':
            lista.add('Mato Grosso');
            break;
          case 'MS':
            lista.add('Mato Grosso do Sul');
            break;
          case 'MG':
            lista.add('Minas Gerais');
            break;
          case 'PA':
            lista.add('Par??');
            break;
          case 'PB':
            lista.add('Para??ba');
            break;
          case 'PR':
            lista.add('Paran??');
            break;
          case 'PE':
            lista.add('Pernambuco');
            break;
          case 'PI':
            lista.add('Piau??');
            break;
          case 'RJ':
            lista.add('Rio de Janeiro');
            break;
          case 'RN':
            lista.add('Rio Grande do Norte');
            break;
          case 'RS':
            lista.add('Rio Grande do Sul');
            break;
          case 'RO':
            lista.add('Rond??nia');
            break;
          case 'RR':
            lista.add('Roraima');
            break;
          case 'SC':
            lista.add('Santa Catarina');
            break;
          case 'SP':
            lista.add('S??o Paulo');
            break;
          case 'SE':
            lista.add('Sergipe');
            break;
          case 'TO':
            lista.add('Tocantins');
            break;
          case 'DF':
            lista.add('Distrito Federal');
            break;
          default:
        }

        lista.add(jsonDecode(response.body)['localidade']);

        statusCep = RegisterStatusCep.success;

        return lista;
      }
    } catch (e) {
      statusCep = RegisterStatusCep.error;
      MeuToast.toast(
          title: 'Aten????o',
          message: 'CEP n??o encontrado.',
          type: TypeToast.error,
          context: cxt);
      rethrow;
    }
  }

  @action
  Future<List<String>> buscaMunicipios({required String uf}) async {
    late String estado = '';
    switch (uf) {
      case 'Acre':
        estado = 'AC';
        break;
      case 'Alagoas':
        estado = 'AL';
        break;
      case 'Amap??':
        estado = 'AP';
        break;
      case 'Amazonas':
        estado = 'AM';
        break;
      case 'Bahai':
        estado = 'BA';
        break;
      case 'Cear??':
        estado = 'CE';
        break;
      case 'Esp??rito Santo':
        estado = 'ES';
        break;
      case 'Goi??s':
        estado = 'GO';
        break;
      case 'Maranh??o':
        estado = 'MA';
        break;
      case 'Mato Grosso':
        estado = 'MT';
        break;
      case 'Mato Grosso do Sul':
        estado = 'MS';
        break;
      case 'Minas Gerais':
        estado = 'MG';
        break;
      case 'Par??':
        estado = 'PA';
        break;
      case 'Para??ba':
        estado = 'PB';
        break;
      case 'Paran??':
        estado = 'PR';
        break;
      case 'Pernambuco':
        estado = 'PE';
        break;
      case 'Piau??':
        estado = 'PI';
        break;
      case 'Rio de Janeiro':
        estado = 'RJ';
        break;
      case 'Rio Grande do Norte':
        estado = 'RN';
        break;
      case 'Rio Grande do Sul':
        estado = 'RS';
        break;
      case 'Rond??nia':
        estado = 'RO';
        break;
      case 'Roraima':
        estado = 'RR';
        break;
      case 'Santa Catarina':
        estado = 'SC';
        break;
      case 'S??o Paulo':
        estado = 'SP';
        break;
      case 'Sergipe':
        estado = 'SE';
        break;
      case 'Tocantins':
        estado = 'TO';
        break;
      case 'Distrito Federal':
        estado = 'DF';
        break;
    }

    final response = await http.get(
      Uri.parse(
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$estado/distritos'),
    );

    late List<String> municipios = [];

    for (var item in jsonDecode(response.body)) {
      municipios.add(item['nome']);
    }

    municipios.sort((a, b) => a.compareTo(b));

    return municipios;
  }

  @action
  Future<bool> verificaCPFCadastrado({String? cpf}) async {
    try {
      status = RegisterStatus.loading;

      if (cpf == null) {
        cpf = user.cpf;
      }

      final response = await http.post(
        Uri.parse(
            '${Constants.baseUrl}/getJson/${Constants.cnpj}/usuarios/${cpf!.replaceAll('.', '').replaceAll('-', '')}'),
      );

      if (jsonDecode(response.body)['CPF'] == cpf) {
        status = RegisterStatus.success;
        return true;
      } else {
        status = RegisterStatus.success;
        return false;
      }
    } catch (e) {
      status = RegisterStatus.error;
      return false;
    }
  }
}
