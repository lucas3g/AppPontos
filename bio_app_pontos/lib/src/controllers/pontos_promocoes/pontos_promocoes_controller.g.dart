// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pontos_promocoes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PontosPromocoesController on _PontosPromocoesControllerBase, Store {
  final _$statusAtom = Atom(name: '_PontosPromocoesControllerBase.status');

  @override
  PontosPromocoesStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(PontosPromocoesStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$carregaDadosAsyncAction =
      AsyncAction('_PontosPromocoesControllerBase.carregaDados');

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
