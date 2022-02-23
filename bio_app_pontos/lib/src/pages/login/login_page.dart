import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/pages/register/register_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  late bool visiblePassword = false;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  GlobalKey<FormState> keySenha = GlobalKey<FormState>();
  GlobalKey<FormState> keyEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.2,
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          padding: EdgeInsets.all(30),
          child: Image.asset(context.image_path),
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
                  formKey: keyEmail,
                  textEditingController: emailController,
                  focusNode: email,
                  hintText: 'E-Mail',
                  campoVazio: 'Digite seu E-Mail',
                  onFieldSubmitted: (value) {
                    password.requestFocus();
                  },
                  onChanged: (String? email) {},
                ),
                SizedBox(height: 10),
                MyInputWidget(
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
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (String? senha) {},
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!keyEmail.currentState!.validate() ||
                              !keySenha.currentState!.validate()) {
                            return;
                          }
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/dashboard',
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Entrar',
                          style:
                              AppTheme.textStyles.button.copyWith(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(0, 45),
                        ),
                      ),
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
