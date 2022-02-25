import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../components/my_input_widget.dart';
import '../../../controllers/register/register_controller.dart';

class PersonEmailPasswordWidget extends StatefulWidget {
  final RegisterController controller;
  const PersonEmailPasswordWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<PersonEmailPasswordWidget> createState() =>
      _PersonEmailPasswordWidgetState();
}

class _PersonEmailPasswordWidgetState extends State<PersonEmailPasswordWidget> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  late RegisterController controller;
  FocusNode email = FocusNode();
  FocusNode password = FocusNode();
  late bool visiblePassword = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controllerEmail.text = controller.user.email ?? '';
    controllerPassword.text = controller.user.senha ?? '';
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyInputWidget(
          textCapitalization: TextCapitalization.none,
          autovalidateMode: AutovalidateMode.always,
          formKey: widget.controller.keyEmail,
          textEditingController: controllerEmail,
          focusNode: email,
          hintText: 'E-Mail',
          campoVazio: 'Digite seu E-Mail',
          onFieldSubmitted: (value) {
            password.requestFocus();
          },
          onChanged: (String? email) {
            widget.controller.copyWith(email: email);
          },
        ),
        SizedBox(height: 10),
        MyInputWidget(
          textCapitalization: TextCapitalization.none,
          formKey: widget.controller.keySenha,
          textEditingController: controllerPassword,
          focusNode: password,
          obscureText: !visiblePassword,
          hintText: 'Senha',
          campoVazio: 'Digite sua Senha',
          suffixIcon: GestureDetector(
            child: Icon(
              visiblePassword ? Icons.visibility : Icons.visibility_off,
              size: 25,
              color:
                  visiblePassword ? AppTheme.colors.primary : Color(0xFF666666),
            ),
            onTap: () {
              visiblePassword = !visiblePassword;
              setState(() {});
            },
          ),
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onChanged: (String? senha) {
            widget.controller.copyWith(senha: senha);
          },
        ),
      ],
    );
  }
}
