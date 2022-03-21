import 'dart:async';

import 'package:bio_app_pontos/src/controllers/maps/maps_status.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
part 'maps_controller.g.dart';

class MapsController = _MapsControllerBase with _$MapsController;

abstract class _MapsControllerBase with Store {
  @observable
  MapsStatus status = MapsStatus.empty;

  @observable
  Set<Marker> markerPosto = {};

  @observable
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(Constants.latitude, Constants.longitude),
    zoom: 18,
  );

  @action
  Future<void> abreMapa() async {
    status = MapsStatus.loading;
    Marker mk = Marker(
      markerId: MarkerId(Constants.idMarker),
      position: LatLng(Constants.latitude, Constants.longitude),
      infoWindow: InfoWindow(
        title: Constants.tituloMarker,
      ),
    );
    markerPosto.add(mk);
    await Future.delayed(Duration(milliseconds: 600));
    status = MapsStatus.success;
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(Constants.latitude, Constants.longitude);
      final title = Constants.tituloMarker;
      final availableMaps = await MapLauncher.installedMaps;

      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      Column(
                        children: [
                          ListTile(
                            onTap: () => map.showMarker(
                              coords: coords,
                              title: title,
                            ),
                            title: Text(map.mapName),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                          Divider()
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      throw 'Nenhum mapa encontrado';
    }
  }

  @action
  Future<void> navigateTo({required BuildContext context}) async {
    openMapsSheet(context);
  }

  @action
  Future<void> goToTheLake(
      {required Completer<GoogleMapController> completer}) async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  }
}
