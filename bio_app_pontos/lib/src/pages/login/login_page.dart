import 'dart:io';

import 'package:bio_app_pontos/src/components/button_login_widget.dart';
import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/pages/forgot_password/forgot_password_page.dart';
import 'package:bio_app_pontos/src/pages/register/register_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();
  final scrollController = ScrollController();
  final controller = GlobalSettings().loginController;
  late bool visiblePassword = false;
  FocusNode cpf = FocusNode();
  FocusNode password = FocusNode();
  GlobalKey<FormState> keySenha = GlobalKey<FormState>();
  GlobalKey<FormState> keyCPF = GlobalKey<FormState>();

  double retornaAltura() {
    late double altura;

    if (Constants.nomeApp == 'Bio Wahl - Cashback' && Platform.isIOS) {
      altura = 35;
    } else if (Constants.nomeApp == 'Bio Wahl - Cashback' &&
        Platform.isAndroid) {
      altura = 30;
    }

    if (Constants.nomeApp != 'Bio Wahl - Cashback' && Platform.isIOS) {
      altura = 55;
    } else if (Constants.nomeApp != 'Bio Wahl - Cashback' &&
        Platform.isAndroid) {
      altura = 50;
    }

    return altura;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.20,
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          padding: EdgeInsets.only(
              top: retornaAltura(), bottom: 30, left: 30, right: 30),
          child: Image.asset(
            context.image_path,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: Platform.isAndroid
                ? context.screenHeight * 0.767
                : context.screenHeight * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(
                  children: [
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      formKey: keyCPF,
                      textEditingController: cpfController,
                      focusNode: cpf,
                      hintText: 'CPF',
                      campoVazio: 'Digite seu CPF',
                      onFieldSubmitted: (value) {
                        password.requestFocus();
                        cpfController.text = value!.trim();
                      },
                      onChanged: (String? cpf) {
                        controller.cpf = cpf!.trim();
                      },
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                    ),
                    SizedBox(height: 10),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          50,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formKey: keySenha,
                      textEditingController: senhaController,
                      focusNode: password,
                      obscureText: !visiblePassword,
                      hintText: 'Senha',
                      campoVazio: 'Digite sua Senha',
                      suffixIcon: GestureDetector(
                        child: Icon(
                          visiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 25,
                          color: visiblePassword
                              ? AppTheme.colors.primary
                              : Color(0xFF666666),
                        ),
                        onTap: () {
                          visiblePassword = !visiblePassword;
                          setState(() {});
                        },
                      ),
                      onFieldSubmitted: (value) async {
                        if (!keyCPF.currentState!.validate() ||
                            !keySenha.currentState!.validate()) {
                          return;
                        }
                        senhaController.text = value!.trim();
                        FocusScope.of(context).requestFocus(FocusNode());
                        await controller.acessarApp(context: context);
                      },
                      onChanged: (String? password) {
                        controller.password = password!.trim();
                      },
                    ),
                    SizedBox(height: 15),
                    ButtonLoginWidget(
                      keySenha: keySenha,
                      keyCPF: keyCPF,
                      controller: controller,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Esqueceu sua senha?',
                        ),
                        TextButton(
                          child: Text('Clique aqui'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: ForgotPassword(),
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: Duration(milliseconds: 500),
                                reverseDuration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignment: Alignment.center,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('N??o tem uma conta ainda?'),
                    TextButton(
                      child: Text('Criar conta'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: RegisterPage(),
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            alignment: Alignment.center,
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
