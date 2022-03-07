import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final controller = GlobalSettings().appSetting;
  final loginController = GlobalSettings().loginController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              Constants.textoSairApp,
              style: AppTheme.textStyles.textoSairApp,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () async {
                await loginController.deslogar();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded),
                  SizedBox(width: 10),
                  Text(
                    'Sair do App',
                    style: AppTheme.textStyles.button,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shadowColor: AppTheme.colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(context.screenWidth * 0.4, 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
