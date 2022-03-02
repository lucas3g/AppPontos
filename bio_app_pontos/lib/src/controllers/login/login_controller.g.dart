// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$cpfAtom = Atom(name: '_LoginControllerBase.cpf');

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginControllerBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$statusAtom = Atom(name: '_LoginControllerBase.status');

  @override
  LoginStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoginStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$acessarAppAsyncAction =
      AsyncAction('_LoginControllerBase.acessarApp');

  @override
  Future<void> acessarApp({required BuildContext context, UserModel? user}) {
    return _$acessarAppAsyncAction
        .run(() => super.acessarApp(context: context, user: user));
  }

  final _$deslogarAsyncAction = AsyncAction('_LoginControllerBase.deslogar');

  @override
  Future<void> deslogar() {
    return _$deslogarAsyncAction.run(() => super.deslogar());
  }

  @override
  String toString() {
    return '''
cpf: ${cpf},
password: ${password},
status: ${status}
    ''';
  }
}
