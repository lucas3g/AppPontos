// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapsController on _MapsControllerBase, Store {
  final _$statusAtom = Atom(name: '_MapsControllerBase.status');

  @override
  MapsStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(MapsStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$markerPostoAtom = Atom(name: '_MapsControllerBase.markerPosto');

  @override
  Set<Marker> get markerPosto {
    _$markerPostoAtom.reportRead();
    return super.markerPosto;
  }

  @override
  set markerPosto(Set<Marker> value) {
    _$markerPostoAtom.reportWrite(value, super.markerPosto, () {
      super.markerPosto = value;
    });
  }

  final _$kGooglePlexAtom = Atom(name: '_MapsControllerBase.kGooglePlex');

  @override
  CameraPosition get kGooglePlex {
    _$kGooglePlexAtom.reportRead();
    return super.kGooglePlex;
  }

  @override
  set kGooglePlex(CameraPosition value) {
    _$kGooglePlexAtom.reportWrite(value, super.kGooglePlex, () {
      super.kGooglePlex = value;
    });
  }

  final _$abreMapaAsyncAction = AsyncAction('_MapsControllerBase.abreMapa');

  @override
  Future<void> abreMapa() {
    return _$abreMapaAsyncAction.run(() => super.abreMapa());
  }

  final _$navigateToAsyncAction = AsyncAction('_MapsControllerBase.navigateTo');

  @override
  Future<void> navigateTo({required BuildContext context}) {
    return _$navigateToAsyncAction
        .run(() => super.navigateTo(context: context));
  }

  final _$goToTheLakeAsyncAction =
      AsyncAction('_MapsControllerBase.goToTheLake');

  @override
  Future<void> goToTheLake(
      {required Completer<GoogleMapController> completer}) {
    return _$goToTheLakeAsyncAction
        .run(() => super.goToTheLake(completer: completer));
  }

  @override
  String toString() {
    return '''
status: ${status},
markerPosto: ${markerPosto},
kGooglePlex: ${kGooglePlex}
    ''';
  }
}
