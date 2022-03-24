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
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      formKey: controller.keyCep,
                      textEditingController: controllerCep,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(),
                      ],
                      focusNode: cep,
                      hintText: 'CEP',
                      campoVazio: 'Digite seu CEP',
                      onFieldSubmitted: (value) async {
                        rua.requestFocus();
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
                        controllerCep.text = value!.trim();
                      },
                      onChanged: (String? cep) {
                        controller.copyWith(cep: cep!.trim());
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Observer(builder: (_) {
                    return ElevatedButton(
                        onPressed: () async {
                          rua.requestFocus();
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
                  Form(
                    key: controller.keyEstado,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite um estado';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: estado,
                      onTap: () {
                        setState(() {
                          onTappedEstado = !onTappedEstado;
                        });
                      },
                      onChanged: (value) {
                        if (!onTappedEstado) {
                          setState(() {
                            onTappedEstado = true;
                          });
                        }
                        filtraEstados(value);
                        if (value.isEmpty) {
                          filteredMunicipios = [];
                          controllerMunicipio.text = '';
                        }
                        controller.copyWith(uf: value.trim());
                      },
                      onFieldSubmitted: (value) {
                        municipio.requestFocus();
                        controllerEstado.text = value.trim();
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
                                        setState(() {
                                          onTappedEstado = !onTappedEstado;
                                        });
                                        controllerEstado.text =
                                            filteredEstados[index];
                                        controller.copyWith(
                                            uf: filteredEstados[index]);
                                        filteredMunicipios = municipios;
                                        controllerMunicipio.text = '';
                                        municipio.requestFocus();
                                        setState(() {});
                                        municipios =
                                            await controller.buscaMunicipios(
                                          uf: filteredEstados[index],
                                        );
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
                  Form(
                    key: controller.keyMunicipio,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite um município';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: municipio,
                      onTap: () {
                        setState(() {
                          onTappedMun = !onTappedMun;
                        });
                      },
                      onChanged: (value) {
                        if (!onTappedMun) {
                          setState(() {
                            onTappedMun = true;
                          });
                        }
                        filtraMunicipios(value);
                        controller.copyWith(municipio: value.trim());
                      },
                      onFieldSubmitted: (value) {
                        rua.requestFocus();
                        controllerMunicipio.text = value.trim();
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
                                        controller.copyWith(
                                            municipio:
                                                filteredMunicipios[index]);
                                        onTappedMun = !onTappedMun;
                                        rua.requestFocus();
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
                autovalidateMode: AutovalidateMode.always,
                formKey: controller.keyRua,
                textEditingController: controllerRua,
                focusNode: rua,
                hintText: 'Rua',
                campoVazio: 'Digite sua Rua',
                onFieldSubmitted: (value) {
                  numero.requestFocus();
                  controllerRua.text = value!.trim();
                },
                onChanged: (String? rua) {
                  controller.copyWith(rua: rua!.trim());
                },
              ),
              SizedBox(height: 10),
              MyInputWidget(
                autovalidateMode: AutovalidateMode.always,
                formKey: controller.keyNumero,
                textEditingController: controllerNumero,
                inputFormaters: [UpperCaseTextFormatter()],
                focusNode: numero,
                hintText: 'Número',
                campoVazio: 'Digite seu Número',
                onFieldSubmitted: (value) {
                  bairro.requestFocus();
                  controllerNumero.text = value!.trim();
                },
                onChanged: (String? numero) {
                  controller.copyWith(numero: numero!.trim());
                },
              ),
              SizedBox(height: 10),
              MyInputWidget(
                autovalidateMode: AutovalidateMode.always,
                formKey: controller.keyBairro,
                textEditingController: controllerBairro,
                focusNode: bairro,
                hintText: 'Bairro',
                campoVazio: 'Digite seu bairro',
                onFieldSubmitted: (value) {
                  complemento.requestFocus();
                  controllerBairro.text = value!.trim();
                },
                onChanged: (String? bairro) {
                  controller.copyWith(bairro: bairro!.trim());
                },
              ),
              SizedBox(height: 10),
              MyInputWidget(
                formKey: controller.keyComplemento,
                textEditingController: controllerComplemento,
                focusNode: complemento,
                hintText: 'Complemento',
                campoVazio: 'Digite seu Complemento',
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  controllerComplemento.text = value!.trim();
                },
                onChanged: (String? complemento) {
                  controller.copyWith(complemento: complemento!.trim());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
