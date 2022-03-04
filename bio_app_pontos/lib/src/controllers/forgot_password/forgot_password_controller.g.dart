// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPasswordController on _ForgotPasswordControllerBase, Store {
  final _$cpfAtom = Atom(name: '_ForgotPasswordControllerBase.cpf');

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

  final _$emailAtom = Atom(name: '_ForgotPasswordControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$statusAtom = Atom(name: '_ForgotPasswordControllerBase.status');

  @override
  ForgotPasswordStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(ForgotPasswordStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$sendEmailPasswordAsyncAction =
      AsyncAction('_ForgotPasswordControllerBase.sendEmailPassword');

  @override
  Future<void> sendEmailPassword({required BuildContext context}) {
    return _$sendEmailPasswordAsyncAction
        .run(() => super.sendEmailPassword(context: context));
  }

  @override
  String toString() {
    return '''
cpf: ${cpf},
email: ${email},
status: ${status}
    ''';
  }
}
