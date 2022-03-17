import 'dart:async';

import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/maps/maps_status.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/loading_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../theme/app_theme.dart';

class LocalizationWidget extends StatefulWidget {
  LocalizationWidget({Key? key}) : super(key: key);

  @override
  State<LocalizationWidget> createState() => _LocalizationWidgetState();
}

class _LocalizationWidgetState extends State<LocalizationWidget> {
  final mapsController = GlobalSettings().mapsController;
  final Completer<GoogleMapController> controllerGoogle = Completer();

  Future<void> carregaMapa() async {
    await mapsController.abreMapa();
  }

  @override
  void initState() {
    super.initState();
    carregaMapa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return mapsController.status == MapsStatus.success
            ? GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: mapsController.kGooglePlex,
                zoomControlsEnabled: false,
                markers: mapsController.markerPosto,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  controllerGoogle.complete(controller);
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
                mapsController.navigateTo(
                    Constants.latitude, Constants.longitude);
              },
              label: Text('Para o posto!'),
              icon: Icon(Icons.local_gas_station_rounded),
              backgroundColor: AppTheme.colors.primary,
            ),
            FloatingActionButton(
              onPressed: () {
                mapsController.goToTheLake(completer: controllerGoogle);
              },
              backgroundColor: AppTheme.colors.primary,
              child: Icon(Icons.my_location_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
