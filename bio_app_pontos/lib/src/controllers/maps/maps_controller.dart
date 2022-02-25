import 'dart:async';

import 'package:bio_app_pontos/src/controllers/maps/maps_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
part 'maps_controller.g.dart';

class MapsController = _MapsControllerBase with _$MapsController;

abstract class _MapsControllerBase with Store {
  @observable
  MapsStatus status = MapsStatus.empty;

  @observable
  Set<Marker> markerPosto = {};

  @observable
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(-27.9512195, -52.9238309),
    zoom: 18,
  );

  @action
  Future<void> abreMapa() async {
    status = MapsStatus.loading;
    Marker mk = Marker(
      markerId: MarkerId('biowahl'),
      position: LatLng(-27.9512195, -52.9238309),
      infoWindow: InfoWindow(
        title: 'Bio Wahl Abastecedora',
      ),
    );
    markerPosto.add(mk);
    await Future.delayed(Duration(milliseconds: 600));
    status = MapsStatus.success;
  }

  @action
  Future<void> navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Não pode ser aberto ${uri.toString()}';
    }
  }

  @action
  Future<void> goToTheLake(
      {required Completer<GoogleMapController> completer}) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  }
}
