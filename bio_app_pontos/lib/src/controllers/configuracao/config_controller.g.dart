// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigController on _ConfigControllerBase, Store {
  final _$statusAtom = Atom(name: '_ConfigControllerBase.status');

  @override
  ConfigStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(ConfigStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$carregaDadosAsyncAction =
      AsyncAction('_ConfigControllerBase.carregaDados');

  @override
  Future<void> carregaDados() {
    return _$carregaDadosAsyncAction.run(() => super.carregaDados());
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
