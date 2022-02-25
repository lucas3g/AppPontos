import 'dart:convert';
import 'dart:io';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_status.dart';
import 'package:bio_app_pontos/src/models/promoces.dart';
import 'package:bio_app_pontos/src/models/saldo.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/services/dio.dart';
import 'package:mobx/mobx.dart';
part 'pontos_promocoes_controller.g.dart';

class PontosPromocoesController = _PontosPromocoesControllerBase
    with _$PontosPromocoesController;

abstract class _PontosPromocoesControllerBase with Store {
  @observable
  ObservableList<PromocoesModel> promocoes = ObservableList.of([]);

  @observable
  SaldoModel saldo = SaldoModel(saldo: 0.0);

  @observable
  PontosPromocoesStatus status = PontosPromocoesStatus.empty;

  @action
  Future<void> carregaDados() async {
    try {
      status = PontosPromocoesStatus.loading;

      final UserModel user = GlobalSettings().appSetting.user;

      final result = await InternetAddress.lookup(MeuDio.baseUrl);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await MeuDio.dio().post(
          '/getJson/01459027/pontos/${user.cpf!.replaceAll('.', '').replaceAll('-', '')}',
        );
        await Future.delayed(Duration(milliseconds: 600));
        if (response.statusCode == 200) {
          saldo.saldo = jsonDecode(response.data)['saldo'];
          promocoes.clear();
          promocoes.add(
            PromocoesModel(
              descricao: 'Wafer Limão - Minueto',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7896011103754',
              quantidade: 3,
              preco: 2.75,
            ),
          );
          promocoes.add(
            PromocoesModel(
              descricao: 'Coca-Cola',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7894900011715',
              quantidade: 3,
              preco: 3.75,
            ),
          );
          promocoes.add(
            PromocoesModel(
              descricao: 'Wafer Limão - Minueto',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7896011103754',
              quantidade: 3,
              preco: 2.75,
            ),
          );
          promocoes.add(
            PromocoesModel(
              descricao: 'Coca-Cola',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7894900011715',
              quantidade: 3,
              preco: 3.75,
            ),
          );
          promocoes.add(
            PromocoesModel(
              descricao: 'Wafer Limão - Minueto',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7896011103754',
              quantidade: 3,
              preco: 2.75,
            ),
          );
          promocoes.add(
            PromocoesModel(
              descricao: 'Coca-Cola',
              path_image:
                  'https://cdn-cosmos.bluesoft.com.br/products/7894900011715',
              quantidade: 3,
              preco: 3.75,
            ),
          );
          status = PontosPromocoesStatus.success;
        } else {
          saldo.copyWith(saldo: 0);
          status = PontosPromocoesStatus.error;
        }
      }
    } catch (e) {
      status = PontosPromocoesStatus.error;
    }
  }
}
