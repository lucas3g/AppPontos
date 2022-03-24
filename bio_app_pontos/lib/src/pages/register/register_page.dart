import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/register/register_status.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_address_widget.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_data_widget.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_email_password.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerPage = PageController();
  final controller = GlobalSettings().registerController;

  late int currentPage = 0;

  Future<void> nextPage() async {
    if (currentPage < 2) {
      currentPage++;
      setState(() {});
      await controllerPage.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  Future<void> backPage() async {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
      await controllerPage.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  String titleAppBar() {
    late String title = '';
    switch (currentPage) {
      case 1:
        title = 'Endereço';
        break;
      case 2:
        title = 'E-Mail e Senha';
        break;
      default:
        title = 'Dados Pessoais';
    }
    return title;
  }

  @override
  void initState() {
    super.initState();
    autorun((_) async {
      if (controller.status == RegisterStatus.cnpjJaCadastrado) {
        MeuToast.toast(
          title: 'Atenção',
          message: 'CPF já cadastrado.',
          type: TypeToast.dadosInv,
          context: context,
        );
      }
    });
  }

  @override
  void dispose() {
    controllerPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(titleAppBar()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (currentPage == 0) {
            controller.user = UserModel();
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: LoginPage(),
                type: PageTransitionType.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
              ),
              (route) => false,
            );
          } else {
            await backPage();
          }
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controllerPage,
            children: [
              PersonDataWidget(
                controller: controller,
              ),
              PersonAddressWidget(
                controller: controller,
              ),
              PersonEmailPasswordWidget(
                controller: controller,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Observer(builder: (context) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 60,
          width: context.screenWidth,
          color: controller.status == RegisterStatus.success
              ? Colors.green.shade500
              : Colors.grey.shade100,
          child: Stack(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: controller.status == RegisterStatus.success ||
                        controller.status == RegisterStatus.loading
                    ? 0
                    : 1,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 60,
                  width: context.screenWidth * 0.50,
                  child: TextButton(
                    onPressed: () async {
                      if (currentPage == 0) {
                        controller.user = UserModel();
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: LoginPage(),
                            type: PageTransitionType.leftToRightWithFade,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            alignment: Alignment.center,
                          ),
                          (route) => false,
                        );
                      } else {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await backPage();
                      }
                    },
                    child: Text(currentPage == 0 ? 'Cancelar' : 'Voltar'),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: controller.status == RegisterStatus.success ||
                        controller.status == RegisterStatus.loading
                    ? 1
                    : context.screenWidth * 0.50,
                duration: Duration(milliseconds: 500),
                width: controller.status == RegisterStatus.success ||
                        controller.status == RegisterStatus.loading
                    ? context.screenWidth
                    : context.screenWidth * 0.50,
                height: 60,
                child: TextButton(
                  onPressed: controller.status != RegisterStatus.loading
                      ? () async {
                          if (currentPage == 0) {
                            if (controller.keyNome.currentState != null) {
                              if (!controller.keyNome.currentState!
                                      .validate() ||
                                  !controller.keyCpf.currentState!.validate() ||
                                  !controller.keyCelular.currentState!
                                      .validate() ||
                                  !controller.keyPlaca.currentState!
                                      .validate()) {
                                return;
                              }
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                            await nextPage();
                          } else if (currentPage == 1) {
                            if (controller.keyCep.currentState != null) {
                              if (!controller.keyCep.currentState!.validate() ||
                                  !controller.keyEstado.currentState!
                                      .validate() ||
                                  !controller.keyMunicipio.currentState!
                                      .validate() ||
                                  !controller.keyRua.currentState!.validate() ||
                                  !controller.keyNumero.currentState!
                                      .validate() ||
                                  !controller.keyBairro.currentState!
                                      .validate()) {
                                return;
                              }
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                            await nextPage();
                          } else if (currentPage == 2) {
                            if (controller.keyEmail.currentState != null) {
                              if (!controller.keyEmail.currentState!
                                      .validate() ||
                                  !controller.keySenha.currentState!
                                      .validate()) {
                                return;
                              }
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (await controller.registerUser(
                                context: context)) {
                              controller.user = UserModel();
                            }
                          }
                        }
                      : null,
                  child: controller.status == RegisterStatus.success
                      ? AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: controller.status == RegisterStatus.success
                              ? 1
                              : 0,
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Cadastro efetuado com sucesso!',
                                  style:
                                      AppTheme.textStyles.textoCadastroSucesso,
                                ),
                              ],
                            ),
                          ),
                        )
                      : controller.status == RegisterStatus.empty ||
                              controller.status == RegisterStatus.error ||
                              controller.status ==
                                  RegisterStatus.cnpjJaCadastrado
                          ? Text(currentPage < 2
                              ? 'Continuar'
                              : 'Finalizar Cadastro')
                          : Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
