import 'package:bio_app_pontos/src/components/my_input_widget.dart';
import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/controllers/forgot_password/forgot_password_status.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FocusNode cpf = FocusNode();
  GlobalKey<FormState> keyCPF = GlobalKey<FormState>();
  final cpfTextEditingController = TextEditingController();
  final forgotPasswordController = GlobalSettings().forgotPasswordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recuperar dados'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Digite o seu CPF para recuperar a senha',
                style: AppTheme.textStyles.textoSairApp,
              ),
              SizedBox(height: 10),
              MyInputWidget(
                autovalidateMode: AutovalidateMode.always,
                formKey: keyCPF,
                textEditingController: cpfTextEditingController,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                focusNode: cpf,
                campoVazio: 'Digite seu CPF',
                keyboardType: TextInputType.number,
                hintText: 'CPF',
                onChanged: (String? cpf) {
                  forgotPasswordController.cpf = cpf!;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(0, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: AppTheme.colors.primary,
                        elevation: 5,
                        textStyle:
                            AppTheme.textStyles.button.copyWith(fontSize: 14),
                      ),
                      onPressed: () async {
                        if (!keyCPF.currentState!.validate()) {
                          return;
                        }
                        FocusScope.of(context).requestFocus(FocusNode());
                        await forgotPasswordController.sendEmailPassword(
                            context: context);
                      },
                      child: Observer(builder: (context) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: forgotPasswordController.status ==
                                          ForgotPasswordStatus.success ||
                                      forgotPasswordController.status ==
                                          ForgotPasswordStatus.empty ||
                                      forgotPasswordController.status ==
                                          ForgotPasswordStatus.error
                                  ? 1
                                  : 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email_rounded),
                                  SizedBox(width: 10),
                                  Text('Recuperar senha'),
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: forgotPasswordController.status ==
                                          ForgotPasswordStatus.success ||
                                      forgotPasswordController.status ==
                                          ForgotPasswordStatus.empty ||
                                      forgotPasswordController.status ==
                                          ForgotPasswordStatus.error
                                  ? 0
                                  : 1,
                              child: Center(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Obs: As instruções serão enviadas para o email cadastrado neste CPF.',
                style: AppTheme.textStyles.textoSairApp,
              )
            ],
          ),
        ));
  }
}
