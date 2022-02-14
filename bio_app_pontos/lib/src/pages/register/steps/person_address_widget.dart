import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/my_input_widget.dart';

class PersonAddressWidget extends StatefulWidget {
  final RegisterController controller;
  const PersonAddressWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PersonAddressWidget> createState() => _PersonAddressWidgetState();
}

class _PersonAddressWidgetState extends State<PersonAddressWidget> {
  late String initialValue = 'Rio Grande do Sul';
  final List<String> estados = ['Rio Grande do Sul', 'São Paulo'];
  final List<String> municipios = ['Ronda Alta', 'Sarandi', 'Constantina'];
  FocusNode cep = FocusNode();
  FocusNode estado = FocusNode();
  FocusNode municipio = FocusNode();
  FocusNode rua = FocusNode();
  FocusNode numero = FocusNode();
  FocusNode bairro = FocusNode();
  FocusNode complemento = FocusNode();
  late RegisterController controller;
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  final TextEditingController controllerMunicipio = TextEditingController();
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final GlobalKey<FormState> keyCep = GlobalKey<FormState>();
  final GlobalKey<FormState> keyEstado = GlobalKey<FormState>();
  final GlobalKey<FormState> keyMunicipio = GlobalKey<FormState>();
  final GlobalKey<FormState> keyRua = GlobalKey<FormState>();
  final GlobalKey<FormState> keyBairro = GlobalKey<FormState>();
  final GlobalKey<FormState> keyNumero = GlobalKey<FormState>();
  final GlobalKey<FormState> keyComplemento = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyInputWidget(
                    formKey: keyCep,
                    textEditingController: controllerCep,
                    inputFormaters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    focusNode: cep,
                    hintText: 'CEP',
                    campoVazio: 'Digite seu CEP',
                    onFieldSubmitted: (value) {
                      estado.requestFocus();
                    },
                    onChanged: (String? cep) {
                      controller.copyWith(cep: cep);
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Buscar CEP'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(120, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            TextDropdownFormField(
              key: keyEstado,
              onChanged: (String? uf) {
                controller.copyWith(uf: uf);
              },
              options: estados,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                isDense: true,
                fillColor: Colors.transparent,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: AppTheme.colors.secondaryColor,
                ),
                labelText: "Estado",
              ),
            ),
            SizedBox(height: 10),
            TextDropdownFormField(
              key: keyMunicipio,
              onChanged: (String? municipio) {
                controller.copyWith(municipio: municipio);
              },
              options: municipios,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                isDense: true,
                fillColor: Colors.transparent,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: AppTheme.colors.secondaryColor,
                ),
                labelText: "Município",
              ),
            ),
            SizedBox(height: 10),
            MyInputWidget(
              formKey: keyRua,
              textEditingController: controllerRua,
              inputFormaters: [UpperCaseTextFormatter()],
              focusNode: rua,
              hintText: 'Rua',
              campoVazio: 'Digite sua Rua',
              onFieldSubmitted: (value) {
                numero.requestFocus();
              },
              onChanged: (String? rua) {
                controller.copyWith(rua: rua);
              },
            ),
            SizedBox(height: 10),
            MyInputWidget(
              formKey: keyNumero,
              textEditingController: controllerNumero,
              inputFormaters: [UpperCaseTextFormatter()],
              focusNode: numero,
              hintText: 'Número',
              campoVazio: 'Digite seu Número',
              onFieldSubmitted: (value) {
                bairro.requestFocus();
              },
              onChanged: (String? numero) {
                controller.copyWith(numero: numero);
              },
            ),
            SizedBox(height: 10),
            MyInputWidget(
              formKey: keyBairro,
              textEditingController: controllerBairro,
              inputFormaters: [UpperCaseTextFormatter()],
              focusNode: bairro,
              hintText: 'Bairro',
              campoVazio: 'Digite seu bairro',
              onFieldSubmitted: (value) {
                complemento.requestFocus();
              },
              onChanged: (String? bairro) {
                controller.copyWith(bairro: bairro);
              },
            ),
            SizedBox(height: 10),
            MyInputWidget(
              formKey: keyComplemento,
              textEditingController: controllerComplemento,
              inputFormaters: [UpperCaseTextFormatter()],
              focusNode: complemento,
              hintText: 'Complemento',
              campoVazio: 'Digite seu Complemento',
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onChanged: (String? complemento) {
                controller.copyWith(complemento: complemento);
              },
            ),
          ],
        ),
      ),
    );
  }
}
