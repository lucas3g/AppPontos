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

  Future<void> carregaDados() async {
    await configController.carregaDados();
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
                                MyInputWidget(
                                  focusNode: configController.fEstado,
                                  hintText: 'Estado',
                                  formKey: configController.keyEstado,
                                  textEditingController: configController
                                      .estadoTextEditingController,
                                  onChanged: (_) {},
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
                    child: Text(
                      'Sair do App',
                      style: AppTheme.textStyles.button,
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
