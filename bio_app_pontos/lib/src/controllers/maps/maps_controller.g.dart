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

  final _$abreMapaAsyncAction = AsyncAction('_MapsControllerBase.abreMapa');

  @override
  Future<void> abreMapa() {
    return _$abreMapaAsyncAction.run(() => super.abreMapa());
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
