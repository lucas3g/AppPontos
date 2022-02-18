import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_status.dart';
import 'package:bio_app_pontos/src/models/promoces.dart';
import 'package:mobx/mobx.dart';
part 'pontos_promocoes_controller.g.dart';

class PontosPromocoesController = _PontosPromocoesControllerBase
    with _$PontosPromocoesController;

abstract class _PontosPromocoesControllerBase with Store {
  @observable
  ObservableList<PromocoesModel> promocoes = ObservableList.of([]);

  @observable
  PontosPromocoesStatus status = PontosPromocoesStatus.empty;

  @action
  Future<void> carregaDados() async {
    status = PontosPromocoesStatus.loading;
    promocoes.clear();
    promocoes.add(
      PromocoesModel(
        descricao: 'Wafer Limão - Minueto',
        path_image: 'https://cdn-cosmos.bluesoft.com.br/products/7896011103754',
        quantidade: 3,
        preco: 2.75,
      ),
    );
    promocoes.add(
      PromocoesModel(
        descricao: 'Coca-Cola',
        path_image: 'https://cdn-cosmos.bluesoft.com.br/products/7894900011715',
        quantidade: 3,
        preco: 3.75,
      ),
    );
    promocoes.add(
      PromocoesModel(
        descricao: 'Wafer Limão - Minueto',
        path_image: 'https://cdn-cosmos.bluesoft.com.br/products/7896011103754',
        quantidade: 3,
        preco: 2.75,
      ),
    );
    promocoes.add(
      PromocoesModel(
        descricao: 'Coca-Cola',
        path_image: 'https://cdn-cosmos.bluesoft.com.br/products/7894900011715',
        quantidade: 3,
        preco: 3.75,
      ),
    );
    status = PontosPromocoesStatus.success;
  }
}
