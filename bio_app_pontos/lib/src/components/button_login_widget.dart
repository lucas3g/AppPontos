import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/login/login_status.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ButtonLoginWidget extends StatefulWidget {
  final GlobalKey<FormState> keySenha;
  final GlobalKey<FormState> keyCPF;
  final LoginController controller;
  ButtonLoginWidget({
    Key? key,
    required this.keySenha,
    required this.keyCPF,
    required this.controller,
  }) : super(key: key);

  @override
  State<ButtonLoginWidget> createState() => _ButtonLoginWidgetState();
}

class _ButtonLoginWidgetState extends State<ButtonLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            if (!widget.keyCPF.currentState!.validate() ||
                !widget.keySenha.currentState!.validate()) {
              return;
            }
            FocusScope.of(context).requestFocus(FocusNode());
            await widget.controller.acessarApp();
          },
          child: Observer(builder: (context) {
            return AnimatedContainer(
              height: 40,
              width: widget.controller.status == LoginStatus.empty ||
                      widget.controller.status == LoginStatus.error ||
                      widget.controller.status == LoginStatus.success ||
                      widget.controller.status == LoginStatus.invalidCPF ||
                      widget.controller.status == LoginStatus.semInternet
                  ? 350
                  : 40,
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: widget.controller.status == LoginStatus.success
                    ? Colors.green
                    : AppTheme.colors.primary,
                borderRadius: BorderRadius.circular(widget.controller.status ==
                            LoginStatus.empty ||
                        widget.controller.status == LoginStatus.error ||
                        widget.controller.status == LoginStatus.success ||
                        widget.controller.status == LoginStatus.invalidCPF ||
                        widget.controller.status == LoginStatus.semInternet
                    ? 10
                    : 50),
              ),
              child: AnimatedCrossFade(
                crossFadeState: widget.controller.status == LoginStatus.empty ||
                        widget.controller.status == LoginStatus.error ||
                        widget.controller.status == LoginStatus.success ||
                        widget.controller.status == LoginStatus.invalidCPF ||
                        widget.controller.status == LoginStatus.semInternet
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 500),
                firstChild: Center(
                  child: Text(
                    'Entrar',
                    style: AppTheme.textStyles.button.copyWith(fontSize: 16),
                  ),
                ),
                secondChild: Center(
                  child: Container(
                    height: 30,
                    width: 30,
                    child: widget.controller.status == LoginStatus.success
                        ? Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 25,
                          )
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
