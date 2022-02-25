import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PersonDataWidget extends StatefulWidget {
  final RegisterController controller;
  PersonDataWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<PersonDataWidget> createState() => _PersonDataWidgetState();
}

class _PersonDataWidgetState extends State<PersonDataWidget> {
  FocusNode nome = FocusNode();
  FocusNode cpf = FocusNode();
  FocusNode celular = FocusNode();
  FocusNode placa = FocusNode();
  late RegisterController controller;
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerCpf = TextEditingController();
  final TextEditingController controllerCelular = TextEditingController();
  final TextEditingController controllerPlaca = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controllerNome.text = controller.user.nome ?? '';
    controllerCpf.text = controller.user.cpf ?? '';
    controllerCelular.text = controller.user.celular ?? '';
    controllerPlaca.text = controller.user.placa ?? '';
  }

  @override
  void dispose() {
    controllerNome.dispose();
    controllerCpf.dispose();
    controllerCelular.dispose();
    controllerPlaca.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyInputWidget(
            textCapitalization: TextCapitalization.words,
            autovalidateMode: AutovalidateMode.always,
            formKey: controller.keyNome,
            textEditingController: controllerNome,
            focusNode: nome,
            hintText: 'Nome Completo',
            campoVazio: 'Digite seu Nome Completo',
            onFieldSubmitted: (value) {
              cpf.requestFocus();
            },
            onChanged: (String? nome) {
              controller.copyWith(nome: nome);
            },
          ),
          SizedBox(height: 10),
          MyInputWidget(
            autovalidateMode: AutovalidateMode.always,
            formKey: controller.keyCpf,
            textEditingController: controllerCpf,
            inputFormaters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            focusNode: cpf,
            campoVazio: 'Digite seu CPF',
            keyboardType: TextInputType.number,
            hintText: 'CPF',
            onFieldSubmitted: (value) {
              celular.requestFocus();
            },
            onChanged: (String? cpf) {
              controller.copyWith(cpf: cpf);
            },
          ),
          SizedBox(height: 10),
          MyInputWidget(
            autovalidateMode: AutovalidateMode.always,
            formKey: controller.keyCelular,
            textEditingController: controllerCelular,
            inputFormaters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
            focusNode: celular,
            campoVazio: 'Digite seu Celular',
            keyboardType: TextInputType.number,
            hintText: 'Celular',
            onFieldSubmitted: (value) {
              placa.requestFocus();
            },
            onChanged: (String? celular) {
              controller.copyWith(celular: celular);
            },
          ),
          SizedBox(height: 10),
          MyInputWidget(
            autovalidateMode: AutovalidateMode.always,
            formKey: controller.keyPlaca,
            textEditingController: controllerPlaca,
            inputFormaters: [UpperCaseTextFormatter()],
            focusNode: placa,
            campoVazio: 'Digite sua Placa',
            hintText: 'Placa',
            maxLength: 7,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onChanged: (String? placa) {
              controller.copyWith(placa: placa);
            },
          ),
        ],
      );
    });
  }
}
