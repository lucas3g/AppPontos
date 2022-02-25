import 'dart:convert';
import 'dart:io';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/register/register_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/services/dio.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
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
  Future<bool> registerUser() async {
    try {
      status = RegisterStatus.loading;
      await Future.delayed(Duration(milliseconds: 600));
      final result = await InternetAddress.lookup(MeuDio.baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (await verificaCPFCadastrado()) {
          status = RegisterStatus.cnpjJaCadastrado;
          return false;
        }
        final response = await MeuDio.dio().post(
            '/setJson/01459027/usuarios/${user.cpf!.replaceAll('.', '').replaceAll('-', '')}',
            data: user.toJson());

        if (response.statusCode == 200) {
          await GlobalSettings().appSetting.setUser(user: user);
          status = RegisterStatus.success;
          return true;
        } else {
          status = RegisterStatus.error;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      status = RegisterStatus.error;
      return false;
    }
  }

  @action
  Future<List<String>> buscaCEP(
      {required String cep, required BuildContext cxt}) async {
    status = RegisterStatus.loading;

    try {
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
          lista.add('Amapá');
          break;
        case 'AM':
          lista.add('Amazonas');
          break;
        case 'BA':
          lista.add('Bahia');
          break;
        case 'CE':
          lista.add('Ceará');
          break;
        case 'ES':
          lista.add('Espírito Santo');
          break;
        case 'GO':
          lista.add('Goiás');
          break;
        case 'MA':
          lista.add('Maranhão');
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
          lista.add('Pará');
          break;
        case 'PB':
          lista.add('Paraíba');
          break;
        case 'PR':
          lista.add('Paraná');
          break;
        case 'PE':
          lista.add('Pernambuco');
          break;
        case 'PI':
          lista.add('Piauí');
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
          lista.add('Rondônia');
          break;
        case 'RR':
          lista.add('Roraima');
          break;
        case 'SC':
          lista.add('Santa Catarina');
          break;
        case 'SP':
          lista.add('São Paulo');
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

      status = RegisterStatus.success;

      return lista;
    } catch (e) {
      status = RegisterStatus.error;
      MeuToast.toast(
          title: 'Ops..',
          message: 'CEP não encontrado.',
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
      case 'Amapá':
        estado = 'AP';
        break;
      case 'Amazonas':
        estado = 'AM';
        break;
      case 'Bahai':
        estado = 'BA';
        break;
      case 'Ceará':
        estado = 'CE';
        break;
      case 'Espírito Santo':
        estado = 'ES';
        break;
      case 'Goiás':
        estado = 'GO';
        break;
      case 'Maranhão':
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
      case 'Pará':
        estado = 'PA';
        break;
      case 'Paraíba':
        estado = 'PB';
        break;
      case 'Paraná':
        estado = 'PR';
        break;
      case 'Pernambuco':
        estado = 'PE';
        break;
      case 'Piauí':
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
      case 'Rondônia':
        estado = 'RO';
        break;
      case 'Roraima':
        estado = 'RR';
        break;
      case 'Santa Catarina':
        estado = 'SC';
        break;
      case 'São Paulo':
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
  Future<bool> verificaCPFCadastrado() async {
    try {
      status = RegisterStatus.loading;

      final response = await MeuDio.dio().post(
        '/getJson/01459027/usuarios/${user.cpf!.replaceAll('.', '').replaceAll('-', '')}',
      );

      if (jsonDecode(response.data)['cpf'] == user.cpf) {
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
