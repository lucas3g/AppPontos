import 'dart:convert';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_status.dart';
import 'package:bio_app_pontos/src/models/promoces.dart';
import 'package:bio_app_pontos/src/models/saldo.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/repositories/check_internent_cpf.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
part 'pontos_promocoes_controller.g.dart';

class PontosPromocoesController = _PontosPromocoesControllerBase
    with _$PontosPromocoesController;

abstract class _PontosPromocoesControllerBase extends CheckInternetCPF
    with Store {
  @observable
  ObservableList<PromocoesModel> promocoes = ObservableList.of([]);

  @observable
  SaldoModel saldo = SaldoModel(saldo: 0.0);

  @observable
  PontosPromocoesStatus status = PontosPromocoesStatus.empty;

  @action
  Future<void> carregaDados() async {
    try {
      promocoes.clear();
      status = PontosPromocoesStatus.loading;

      final UserModel user = GlobalSettings().appSetting.user;

      if (await checkInternetService.haveInternet()) {
        final response = await http.get(
          Uri.parse(
              '${Constants.baseUrl}/getJson/${Constants.cnpj}/pontos/${user.cpf!.replaceAll('.', '').replaceAll('-', '')}'),
        );
        await Future.delayed(Duration(milliseconds: 600));
        if (response.statusCode == 200) {
          saldo.saldo = jsonDecode(response.body)['saldo'];
        }

        await buscaOfertas();

        status = PontosPromocoesStatus.success;
      } else {
        saldo = saldo.copyWith(saldo: 0);
        await buscaOfertas();
        status = PontosPromocoesStatus.error;
      }
    } catch (e) {
      saldo = saldo.copyWith(saldo: 0);
      await buscaOfertas();
      status = PontosPromocoesStatus.error;
    }
  }

  @action
  Future<void> buscaOfertas() async {
    promocoes.clear();
    final responsePromocoes = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/getJson/${Constants.cnpj}/ofertas/ofertas'),
    );

    if (responsePromocoes.statusCode == 200 && responsePromocoes.body != "") {
      final promocoesApi =
          jsonDecode(responsePromocoes.body).map<PromocoesModel>((e) {
        return PromocoesModel(
          descricao: e['descricao'],
          path_image:
              'https://cdn-cosmos.bluesoft.com.br/products/${e['gtin']}',
          quantidade: 0,
          preco: e['vendaPromocao'],
        );
      }).toList();

      if (promocoesApi == null) {
        promocoes = ObservableList.of([]);
        return;
      }
      promocoes = ObservableList.of(promocoesApi);
    } else {
      promocoes = ObservableList.of([]);
    }
  }
}
