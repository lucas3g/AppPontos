import 'package:bio_app_pontos/src/controllers/historico/historico_status.dart';
import 'package:bio_app_pontos/src/models/itens.dart';
import 'package:mobx/mobx.dart';
part 'historico_controller.g.dart';

class HistoricoController = _HistoricoControllerBase with _$HistoricoController;

abstract class _HistoricoControllerBase with Store {
  @observable
  HistoricoStatus status = HistoricoStatus.empty;

  @observable
  ObservableList<Itens> itens_venda = ObservableList.of([]);

  @action
  Future<void> carregaHistorico() async {
    status = HistoricoStatus.loading;
    itens_venda.clear();
    await Future.delayed(Duration(milliseconds: 600));
    itens_venda.addAll(
      List.generate(
        10,
        (index) => Itens(
            merc: 'Gasolina Comum aaaaaaaaaaaaaaaaaa', vlrUni: 8, qtd: 10000),
      ),
    );
    status = HistoricoStatus.success;
  }
}
