// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterControllerBase, Store {
  final _$userAtom = Atom(name: '_RegisterControllerBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$statusAtom = Atom(name: '_RegisterControllerBase.status');

  @override
  RegisterStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(RegisterStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$statusCepAtom = Atom(name: '_RegisterControllerBase.statusCep');

  @override
  RegisterStatusCep get statusCep {
    _$statusCepAtom.reportRead();
    return super.statusCep;
  }

  @override
  set statusCep(RegisterStatusCep value) {
    _$statusCepAtom.reportWrite(value, super.statusCep, () {
      super.statusCep = value;
    });
  }

  final _$aceitouTermosAtom =
      Atom(name: '_RegisterControllerBase.aceitouTermos');

  @override
  bool get aceitouTermos {
    _$aceitouTermosAtom.reportRead();
    return super.aceitouTermos;
  }

  @override
  set aceitouTermos(bool value) {
    _$aceitouTermosAtom.reportWrite(value, super.aceitouTermos, () {
      super.aceitouTermos = value;
    });
  }

  final _$keyNomeAtom = Atom(name: '_RegisterControllerBase.keyNome');

  @override
  GlobalKey<FormState> get keyNome {
    _$keyNomeAtom.reportRead();
    return super.keyNome;
  }

  @override
  set keyNome(GlobalKey<FormState> value) {
    _$keyNomeAtom.reportWrite(value, super.keyNome, () {
      super.keyNome = value;
    });
  }

  final _$keyCpfAtom = Atom(name: '_RegisterControllerBase.keyCpf');

  @override
  GlobalKey<FormState> get keyCpf {
    _$keyCpfAtom.reportRead();
    return super.keyCpf;
  }

  @override
  set keyCpf(GlobalKey<FormState> value) {
    _$keyCpfAtom.reportWrite(value, super.keyCpf, () {
      super.keyCpf = value;
    });
  }

  final _$keyCelularAtom = Atom(name: '_RegisterControllerBase.keyCelular');

  @override
  GlobalKey<FormState> get keyCelular {
    _$keyCelularAtom.reportRead();
    return super.keyCelular;
  }

  @override
  set keyCelular(GlobalKey<FormState> value) {
    _$keyCelularAtom.reportWrite(value, super.keyCelular, () {
      super.keyCelular = value;
    });
  }

  final _$keyPlacaAtom = Atom(name: '_RegisterControllerBase.keyPlaca');

  @override
  GlobalKey<FormState> get keyPlaca {
    _$keyPlacaAtom.reportRead();
    return super.keyPlaca;
  }

  @override
  set keyPlaca(GlobalKey<FormState> value) {
    _$keyPlacaAtom.reportWrite(value, super.keyPlaca, () {
      super.keyPlaca = value;
    });
  }

  final _$keyEmailAtom = Atom(name: '_RegisterControllerBase.keyEmail');

  @override
  GlobalKey<FormState> get keyEmail {
    _$keyEmailAtom.reportRead();
    return super.keyEmail;
  }

  @override
  set keyEmail(GlobalKey<FormState> value) {
    _$keyEmailAtom.reportWrite(value, super.keyEmail, () {
      super.keyEmail = value;
    });
  }

  final _$keySenhaAtom = Atom(name: '_RegisterControllerBase.keySenha');

  @override
  GlobalKey<FormState> get keySenha {
    _$keySenhaAtom.reportRead();
    return super.keySenha;
  }

  @override
  set keySenha(GlobalKey<FormState> value) {
    _$keySenhaAtom.reportWrite(value, super.keySenha, () {
      super.keySenha = value;
    });
  }

  final _$registerUserAsyncAction =
      AsyncAction('_RegisterControllerBase.registerUser');

  @override
  Future<bool> registerUser({required BuildContext context}) {
    return _$registerUserAsyncAction
        .run(() => super.registerUser(context: context));
  }

  final _$buscaCEPAsyncAction = AsyncAction('_RegisterControllerBase.buscaCEP');

  @override
  Future<List<String>> buscaCEP(
      {required String cep, required BuildContext cxt}) {
    return _$buscaCEPAsyncAction.run(() => super.buscaCEP(cep: cep, cxt: cxt));
  }

  final _$buscaMunicipiosAsyncAction =
      AsyncAction('_RegisterControllerBase.buscaMunicipios');

  @override
  Future<List<String>> buscaMunicipios({required String uf}) {
    return _$buscaMunicipiosAsyncAction
        .run(() => super.buscaMunicipios(uf: uf));
  }

  final _$verificaCPFCadastradoAsyncAction =
      AsyncAction('_RegisterControllerBase.verificaCPFCadastrado');

  @override
  Future<bool> verificaCPFCadastrado({String? cpf}) {
    return _$verificaCPFCadastradoAsyncAction
        .run(() => super.verificaCPFCadastrado(cpf: cpf));
  }

  final _$_RegisterControllerBaseActionController =
      ActionController(name: '_RegisterControllerBase');

  @override
  void copyWith(
      {String? nome,
      String? email,
      String? senha,
      String? cpf,
      String? celular,
      String? placa,
      String? uf,
      String? municipio,
      String? rua,
      String? numero,
      String? bairro,
      String? complemento,
      String? cep}) {
    final _$actionInfo = _$_RegisterControllerBaseActionController.startAction(
        name: '_RegisterControllerBase.copyWith');
    try {
      return super.copyWith(
          nome: nome,
          email: email,
          senha: senha,
          cpf: cpf,
          celular: celular,
          placa: placa,
          uf: uf,
          municipio: municipio,
          rua: rua,
          numero: numero,
          bairro: bairro,
          complemento: complemento,
          cep: cep);
    } finally {
      _$_RegisterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
status: ${status},
statusCep: ${statusCep},
aceitouTermos: ${aceitouTermos},
keyNome: ${keyNome},
keyCpf: ${keyCpf},
keyCelular: ${keyCelular},
keyPlaca: ${keyPlaca},
keyEmail: ${keyEmail},
keySenha: ${keySenha}
    ''';
  }
}
