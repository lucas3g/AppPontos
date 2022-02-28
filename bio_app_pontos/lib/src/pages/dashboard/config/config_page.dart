import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/configuracao/config_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:page_transition/page_transition.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final controller = GlobalSettings().appSetting;
  final configController = GlobalSettings().configController;
  final registerController = GlobalSettings().registerController;

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

  late bool onTappedEstado = false;

  Future<void> carregaDados() async {
    await configController.carregaDados();
  }

  void filtraEstados(String value) async {
    filteredEstados = estados
        .where((e) => (e.toLowerCase().contains(value.toLowerCase())))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Observer(builder: (context) {
              return configController.status == ConfigStatus.success
                  ? Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                MyInputWidget(
                                  focusNode: configController.fNome,
                                  hintText: 'Nome',
                                  formKey: configController.keyNome,
                                  textEditingController: configController
                                      .nomeTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fCPF,
                                  hintText: 'CPF',
                                  formKey: configController.keyCPF,
                                  textEditingController:
                                      configController.cpfTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fCelular,
                                  hintText: 'Celular',
                                  formKey: configController.keyCelular,
                                  textEditingController: configController
                                      .celularTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fEmail,
                                  hintText: 'E-Mail',
                                  formKey: configController.keyEmail,
                                  textEditingController: configController
                                      .emailTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fPlaca,
                                  hintText: 'Placa',
                                  formKey: configController.keyPlaca,
                                  textEditingController: configController
                                      .placaTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fCEP,
                                  hintText: 'CEP',
                                  formKey: configController.keyCEP,
                                  textEditingController:
                                      configController.cepTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                Column(
                                  children: [
                                    TextFormField(
                                      onTap: () async {
                                        setState(() {
                                          onTappedEstado = !onTappedEstado;
                                        });
                                      },
                                      onChanged: (value) {
                                        filtraEstados(value);
                                        if (value.isEmpty) {
                                          filteredMunicipios = [];
                                          configController
                                              .munTextEditingController
                                              .text = '';
                                        }
                                      },
                                      controller: configController
                                          .estadoTextEditingController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: configController
                                                    .estadoTextEditingController
                                                    .text
                                                    .isNotEmpty
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
                                          margin: EdgeInsets.only(
                                              top: 15, left: 5, right: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppTheme.colors.primary),
                                          ),
                                          child: Container(
                                            height: 180,
                                            child: filteredEstados.isNotEmpty
                                                ? ListView.separated(
                                                    itemBuilder:
                                                        (_, int index) {
                                                      return ListTile(
                                                        onTap: () async {
                                                          onTappedEstado =
                                                              !onTappedEstado;
                                                          configController
                                                                  .estadoTextEditingController
                                                                  .text =
                                                              filteredEstados[
                                                                  index];
                                                          municipios =
                                                              await registerController
                                                                  .buscaMunicipios(
                                                            uf: filteredEstados[
                                                                index],
                                                          );
                                                          filteredMunicipios =
                                                              municipios;
                                                          configController
                                                              .munTextEditingController
                                                              .text = '';
                                                          setState(() {});
                                                        },
                                                        title: Text(
                                                            filteredEstados[
                                                                index]),
                                                      );
                                                    },
                                                    separatorBuilder: (_, __) =>
                                                        Divider(),
                                                    itemCount:
                                                        filteredEstados.length,
                                                  )
                                                : SizedBox(
                                                    width: double.maxFinite,
                                                    child: Center(
                                                      child: Text(
                                                        'Nenhum estado encontrado.',
                                                        style: AppTheme
                                                            .textStyles.button
                                                            .copyWith(
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
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fMun,
                                  hintText: 'Município',
                                  formKey: configController.keyMun,
                                  textEditingController:
                                      configController.munTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fRua,
                                  hintText: 'Endereço',
                                  formKey: configController.keyRua,
                                  textEditingController:
                                      configController.ruaTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fNumero,
                                  hintText: 'Número',
                                  formKey: configController.keyNumero,
                                  textEditingController: configController
                                      .numeroTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fBairro,
                                  hintText: 'Bairro',
                                  formKey: configController.keyBairro,
                                  textEditingController: configController
                                      .bairroTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                                MyInputWidget(
                                  focusNode: configController.fComplemento,
                                  hintText: 'Complemento',
                                  formKey: configController.keyComplemento,
                                  textEditingController: configController
                                      .complementoTextEditingController,
                                  onChanged: (_) {},
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (_, __) =>
                            LoadingWidget(size: Size(0, 50), radius: 10),
                        separatorBuilder: (_, __) => SizedBox(height: 15),
                        itemCount: 10,
                      ),
                    );
            }),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.save_as_rounded),
                        Text(
                          'Salvar dados',
                          style: AppTheme.textStyles.button,
                        ),
                        SizedBox()
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: AppTheme.colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.setLogado(conectado: 'N');
                      controller.user = UserModel();
                      await Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          child: LoginPage(),
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          alignment: Alignment.center,
                        ),
                        (route) => false,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout_rounded),
                        Text(
                          'Sair do App',
                          style: AppTheme.textStyles.button,
                        ),
                        SizedBox()
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: AppTheme.colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
