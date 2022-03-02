import 'package:bio_app_pontos/src/components/button_login_widget.dart';
import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_status.dart';
import 'package:bio_app_pontos/src/pages/register/register_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/meu_toast.dart';
import 'package:bio_app_pontos/src/utils/types_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();
  final controller = GlobalSettings().loginController;
  late bool visiblePassword = false;
  FocusNode cpf = FocusNode();
  FocusNode password = FocusNode();
  GlobalKey<FormState> keySenha = GlobalKey<FormState>();
  GlobalKey<FormState> keyCPF = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    autorun((_) async {
      if (controller.status == LoginStatus.success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (controller.status == LoginStatus.error) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Não Foi Possivel Fazer Login.Verifique seus Dados.',
            type: TypeToast.error,
            context: context);
      } else if (controller.status == LoginStatus.semInternet) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Parece que você está sem Internet',
            type: TypeToast.noNet,
            context: context);
      } else if (controller.status == LoginStatus.invalidCPF) {
        MeuToast.toast(
            title: 'Ops... :(',
            message: 'Você digitou um CPF inválido.',
            type: TypeToast.dadosInv,
            context: context);
      } else if (controller.status == LoginStatus.naoAutorizado) {
        MeuToast.toast(
            title: 'Ops... :(',
            message:
                'Seu usuário não tem permissão para acessar o aplicativo.\nVerifique seu usuário e/ou senha.',
            type: TypeToast.dadosInv,
            context: context);
      }
    });
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
          padding: EdgeInsets.all(30),
          child: Image.asset(
            context.image_path,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                MyInputWidget(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  formKey: keyCPF,
                  textEditingController: cpfController,
                  focusNode: cpf,
                  hintText: 'CPF',
                  campoVazio: 'Digite seu CPF',
                  onFieldSubmitted: (value) {
                    password.requestFocus();
                  },
                  onChanged: (String? cpf) {
                    controller.cpf = cpf!;
                  },
                  inputFormaters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                ),
                SizedBox(height: 10),
                MyInputWidget(
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
                      visiblePassword ? Icons.visibility : Icons.visibility_off,
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
                    FocusScope.of(context).requestFocus(FocusNode());
                    await controller.acessarApp();
                  },
                  onChanged: (String? password) {
                    controller.password = password!;
                  },
                ),
                SizedBox(height: 15),
                ButtonLoginWidget(
                  keySenha: keySenha,
                  keyCPF: keyCPF,
                  controller: controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Esqueceu sua senha?',
                    ),
                    TextButton(
                      child: Text('Clique aqui'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Não tem uma conta ainda?'),
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
    );
  }
}
