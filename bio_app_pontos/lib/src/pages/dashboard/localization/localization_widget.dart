import 'dart:async';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/maps/maps_status.dart';
import 'package:bio_app_pontos/src/utils/loading_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../theme/app_theme.dart';

class LocalizationWidget extends StatefulWidget {
  LocalizationWidget({Key? key}) : super(key: key);

  @override
  State<LocalizationWidget> createState() => _LocalizationWidgetState();
}

class _LocalizationWidgetState extends State<LocalizationWidget> {
  Completer<GoogleMapController> _controller = Completer();
  final mapsController = GlobalSettings().mapsController;

  late bool carregandoMapa = true;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-27.9512195, -52.9238309),
    zoom: 18,
  );

  Set<Marker> markerPosto = {};

  Future<void> inicializarMarker() async {
    Marker mk = Marker(
      markerId: MarkerId('biowahl'),
      position: LatLng(-27.9512195, -52.9238309),
      infoWindow: InfoWindow(
        title: 'Bio Abastecedora Wahl',
      ),
    );
    markerPosto.add(mk);
    await mapsController.abreMapa();
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Não pode ser aberto ${uri.toString()}';
    }
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void initState() {
    super.initState();
    inicializarMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return mapsController.status == MapsStatus.success
            ? GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                zoomControlsEnabled: false,
                markers: markerPosto,
                mapToolbarEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              )
            : LoadingWidget(
                size: Size(double.maxFinite, double.maxFinite), radius: 10);
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                navigateTo(-27.9512195, -52.9238309);
              },
              label: Text('Para o posto!'),
              icon: Icon(Icons.local_gas_station_rounded),
              backgroundColor: AppTheme.colors.primary,
            ),
            FloatingActionButton(
              onPressed: _goToTheLake,
              backgroundColor: AppTheme.colors.primary,
              child: Icon(Icons.my_location_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
