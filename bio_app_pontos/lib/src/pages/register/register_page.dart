import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_address_widget.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_data_widget.dart';
import 'package:bio_app_pontos/src/pages/register/steps/person_email_password.dart';
import 'package:flutter/material.dart';

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
      default:
        title = 'Dados Pessoais';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(titleAppBar()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: PageView(
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
      bottomSheet: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    if (currentPage == 0) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                        (route) => false,
                      );
                    } else {
                      await backPage();
                    }
                  },
                  child: Text(currentPage == 0 ? 'Cancelar' : 'Voltar'),
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Container(
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    if (currentPage < 2) {
                      if (controller.keyNome.currentState != null) {
                        if (!controller.keyNome.currentState!.validate() ||
                            !controller.keyCpf.currentState!.validate() ||
                            !controller.keyCelular.currentState!.validate() ||
                            !controller.keyPlaca.currentState!.validate()) {
                          return;
                        }
                      }

                      await nextPage();
                    } else {
                      if (controller.keyEmail.currentState != null) {
                        if (!controller.keyEmail.currentState!.validate() ||
                            !controller.keySenha.currentState!.validate()) {
                          return;
                        }
                      }
                      await controller.registerUser(user: controller.user);
                      controller.user = UserModel();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Text(
                      currentPage < 2 ? 'Continuar' : 'Finalizar Cadastro'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
