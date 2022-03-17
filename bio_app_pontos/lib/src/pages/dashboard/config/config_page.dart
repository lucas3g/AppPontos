import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final controller = GlobalSettings().appSetting;
  final loginController = GlobalSettings().loginController;

  Future<void> sairdoApp() async {
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
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    Constants.textoSairApp,
                    style: AppTheme.textStyles.textoSairApp,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SlideAction(
              animationDuration: Duration(milliseconds: 500),
              borderRadius: 10,
              height: 50,
              sliderButtonIconPadding: 10,
              outerColor: Colors.white,
              elevation: 5,
              innerColor: AppTheme.colors.primary,
              sliderButtonIcon: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
              text: 'Arraste para sair do app',
              textStyle: AppTheme.textStyles.button
                  .copyWith(fontSize: 16, color: AppTheme.colors.primary),
              onSubmit: sairdoApp,
              submittedIcon: Icon(
                Icons.check_rounded,
                color: AppTheme.colors.primary,
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 10),
            //         alignment: Alignment.center,
            //         height: 50,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade500,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //                 margin: EdgeInsets.all(2),
            //                 decoration: BoxDecoration(
            //                     color: Colors.red,
            //                     borderRadius: BorderRadius.circular(50)),
            //                 child: LottieBuilder.asset(
            //                     'assets/images/swipe_right.json')),
            //             Text(
            //               'Deslize para sair do App',
            //               style: AppTheme.textStyles.button,
            //             ),
            //             SizedBox(),
            //             SizedBox(),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // )

            // ElevatedButton(
            //   onPressed: () async {
            // await loginController.deslogar();
            // controller.user = UserModel();
            // await Navigator.pushAndRemoveUntil(
            //   context,
            //   PageTransition(
            //     child: LoginPage(),
            //     type: PageTransitionType.rightToLeftWithFade,
            //     duration: Duration(milliseconds: 500),
            //     curve: Curves.easeInOut,
            //     alignment: Alignment.center,
            //   ),
            //   (route) => false,
            // );
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.logout_rounded),
            //       SizedBox(width: 10),
            //       Text(
            //         'Sair do App',
            //         style: AppTheme.textStyles.button,
            //       ),
            //     ],
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     elevation: 5,
            //     shadowColor: AppTheme.colors.primary,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     fixedSize: Size(context.screenWidth * 0.4, 40),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
