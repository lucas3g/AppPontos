// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historico_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoricoController on _HistoricoControllerBase, Store {
  final _$statusAtom = Atom(name: '_HistoricoControllerBase.status');

  @override
  HistoricoStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(HistoricoStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$itens_vendaAtom = Atom(name: '_HistoricoControllerBase.itens_venda');

  @override
  ObservableList<Itens> get itens_venda {
    _$itens_vendaAtom.reportRead();
    return super.itens_venda;
  }

  @override
  set itens_venda(ObservableList<Itens> value) {
    _$itens_vendaAtom.reportWrite(value, super.itens_venda, () {
      super.itens_venda = value;
    });
  }

  final _$carregaHistoricoAsyncAction =
      AsyncAction('_HistoricoControllerBase.carregaHistorico');

  @override
  Future<void> carregaHistorico() {
    return _$carregaHistoricoAsyncAction.run(() => super.carregaHistorico());
  }

  @override
  String toString() {
    return '''
status: ${status},
itens_venda: ${itens_venda}
    ''';
  }
}
