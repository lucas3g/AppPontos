import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_status.dart';
import 'package:mobx/mobx.dart';
part 'pontos_promocoes_controller.g.dart';

class PontosPromocoesController = _PontosPromocoesControllerBase
    with _$PontosPromocoesController;

abstract class _PontosPromocoesControllerBase with Store {
  @observable
  PontosPromocoesStatus status = PontosPromocoesStatus.empty;

  @action
  Future<void> carregaDados() async {
    status = PontosPromocoesStatus.loading;
    await Future.delayed(Duration(milliseconds: 600));
    status = PontosPromocoesStatus.success;
  }
}
