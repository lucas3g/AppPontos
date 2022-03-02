import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/my_input_widget.dart';
import '../../../controllers/register/register_status_cep.dart';

class PersonAddressWidget extends StatefulWidget {
  final RegisterController controller;
  const PersonAddressWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PersonAddressWidget> createState() => _PersonAddressWidgetState();
}

class _PersonAddressWidgetState extends State<PersonAddressWidget> {
  late String initialValue = 'Rio Grande do Sul';
  final List<String> estados = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
    'Distrito Federal',
  ];
  late List<String> filteredEstados = [];
  late List<String> municipios = [];
  late List<String> filteredMunicipios = [];
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

  late bool onTappedEstado = false;
  late bool onTappedMun = false;

  void filtraEstados(String value) async {
    filteredEstados = estados
        .where((e) => (e.toLowerCase().contains(value.toLowerCase())))
        .toList();
    setState(() {});
  }

  void filtraMunicipios(String value) async {
    filteredMunicipios = municipios
        .where((e) => (e.toLowerCase().contains(value.toLowerCase())))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controllerCep.text = controller.user.cep ?? '';
    controllerEstado.text = controller.user.uf ?? '';
    controllerMunicipio.text = controller.user.municipio ?? '';
    controllerRua.text = controller.user.rua ?? '';
    controllerNumero.text = controller.user.numero ?? '';
    controllerBairro.text = controller.user.bairro ?? '';
    controllerComplemento.text = controller.user.complemento ?? '';
    filteredEstados = estados;
  }

  @override
  void dispose() {
    controllerCep.dispose();
    controllerEstado.dispose();
    controllerMunicipio.dispose();
    controllerRua.dispose();
    controllerNumero.dispose();
    controllerBairro.dispose();
    controllerComplemento.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyInputWidget(
                      keyboardType: TextInputType.number,
                      formKey: keyCep,
                      textEditingController: controllerCep,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(),
                      ],
                      focusNode: cep,
                      hintText: 'CEP',
                      campoVazio: 'Digite seu CEP',
                      onFieldSubmitted: (value) async {
                        final lista = await controller.buscaCEP(
                            cep: controllerCep.text, cxt: context);
                        setState(() {
                          controllerEstado.text = lista[0];
                          controllerMunicipio.text = lista[1];

                          controller.copyWith(uf: lista[0]);
                          controller.copyWith(municipio: lista[1]);
                          filtraEstados(lista[0]);
                          filtraMunicipios(lista[1]);
                        });
                        municipios = await controller.buscaMunicipios(
                          uf: lista[0],
                        );
                        filteredMunicipios = municipios;
                        estado.requestFocus();
                      },
                      onChanged: (String? cep) {
                        controller.copyWith(cep: cep);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Observer(builder: (_) {
                    return ElevatedButton(
                        onPressed: () async {
                          final lista = await controller.buscaCEP(
                              cep: controllerCep.text, cxt: context);
                          setState(() {
                            controllerEstado.text = lista[0];
                            controllerMunicipio.text = lista[1];

                            controller.copyWith(uf: lista[0]);
                            controller.copyWith(municipio: lista[1]);
                            filtraEstados(lista[0]);
                            filtraMunicipios(lista[1]);
                          });
                          municipios = await controller.buscaMunicipios(
                            uf: lista[0],
                          );
                          filteredMunicipios = municipios;
                        },
                        child:
                            controller.statusCep == RegisterStatusCep.success ||
                                    controller.statusCep ==
                                        RegisterStatusCep.empty ||
                                    controller.statusCep ==
                                        RegisterStatusCep.error ||
                                    controller.statusCep ==
                                        RegisterStatusCep.cnpjJaCadastrado
                                ? Text('Buscar CEP')
                                : Container(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(120, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ));
                  })
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  TextFormField(
                    onTap: () {
                      setState(() {
                        onTappedEstado = !onTappedEstado;
                      });
                    },
                    onChanged: (value) {
                      filtraEstados(value);
                      if (value.isEmpty) {
                        filteredMunicipios = [];
                        controllerMunicipio.text = '';
                      }
                    },
                    controller: controllerEstado,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: controllerEstado.text.isNotEmpty
                              ? AppTheme.colors.primary
                              : Colors.grey.shade700,
                        ),
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.transparent,
                      suffixIcon: AnimatedRotation(
                        turns: onTappedEstado ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                        ),
                      ),
                      labelText: "Estado",
                    ),
                  ),
                  AnimatedAlign(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    heightFactor: onTappedEstado ? 1 : 0,
                    child: AnimatedOpacity(
                      opacity: onTappedEstado ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppTheme.colors.primary),
                        ),
                        child: Container(
                          height: 180,
                          child: filteredEstados.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (_, int index) {
                                    return ListTile(
                                      onTap: () async {
                                        onTappedEstado = !onTappedEstado;
                                        controllerEstado.text =
                                            filteredEstados[index];
                                        municipios =
                                            await controller.buscaMunicipios(
                                          uf: filteredEstados[index],
                                        );
                                        filteredMunicipios = municipios;
                                        controllerMunicipio.text = '';
                                        setState(() {});
                                      },
                                      title: Text(filteredEstados[index]),
                                    );
                                  },
                                  separatorBuilder: (_, __) => Divider(),
                                  itemCount: filteredEstados.length,
                                )
                              : SizedBox(
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      'Nenhum estado encontrado.',
                                      style:
                                          AppTheme.textStyles.button.copyWith(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  TextFormField(
                    onTap: () {
                      setState(() {
                        onTappedMun = !onTappedMun;
                      });
                    },
                    onChanged: (value) {
                      filtraMunicipios(value);
                    },
                    controller: controllerMunicipio,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: controllerMunicipio.text.isNotEmpty
                              ? AppTheme.colors.primary
                              : Colors.grey.shade700,
                        ),
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.transparent,
                      suffixIcon: AnimatedRotation(
                        turns: onTappedMun ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 30,
                        ),
                      ),
                      labelText: "Município",
                    ),
                  ),
                  AnimatedAlign(
                    alignment: Alignment.center,
                    duration: Duration(milliseconds: 300),
                    heightFactor: onTappedMun ? 1 : 0,
                    child: AnimatedOpacity(
                      opacity: onTappedMun ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppTheme.colors.primary),
                        ),
                        child: Container(
                          height: 180,
                          child: filteredMunicipios.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (_, int index) {
                                    return ListTile(
                                      onTap: () {
                                        controllerMunicipio.text =
                                            filteredMunicipios[index];
                                        onTappedMun = !onTappedMun;
                                        setState(() {});
                                      },
                                      title: Text(filteredMunicipios[index]),
                                    );
                                  },
                                  separatorBuilder: (_, __) => Divider(),
                                  itemCount: filteredMunicipios.length,
                                )
                              : SizedBox(
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      'Nenhum município encontrado.',
                                      style:
                                          AppTheme.textStyles.button.copyWith(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              MyInputWidget(
                formKey: keyRua,
                textEditingController: controllerRua,
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
      ),
    );
  }
}
