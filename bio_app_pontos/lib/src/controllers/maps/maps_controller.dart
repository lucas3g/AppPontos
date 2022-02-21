import 'package:bio_app_pontos/src/controllers/maps/maps_status.dart';
import 'package:mobx/mobx.dart';
part 'maps_controller.g.dart';

class MapsController = _MapsControllerBase with _$MapsController;

abstract class _MapsControllerBase with Store {
  @observable
  MapsStatus status = MapsStatus.empty;

  @action
  Future<void> abreMapa() async {
    status = MapsStatus.loading;
    await Future.delayed(Duration(milliseconds: 600));
    status = MapsStatus.success;
  }
}
