import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  final texto =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              texto,
              textAlign: TextAlign.justify,
              style: AppTheme.textStyles.textoSairApp,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
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
                  elevation: 5, shadowColor: AppTheme.colors.primary),
            )
          ],
        ),
      ),
    );
  }
}
