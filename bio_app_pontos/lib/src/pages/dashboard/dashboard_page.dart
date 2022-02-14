import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/historico/historico_widget.dart';
import 'package:bio_app_pontos/src/pages/dashboard/pontos/pontos_widget.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late int currentIndex = 0;
  late UserModel? user;
  var pages = [
    PontosWidget(),
    HistorioWidget(),
  ];

  @override
  void initState() {
    super.initState();

    user = GlobalSettings().appSetting.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.secondaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: context.screenHeight * 0.15,
        elevation: 0,
        title: Container(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Bem-Vindo',
                    style: AppTheme.textStyles.title
                        .copyWith(fontSize: 16, color: AppTheme.colors.primary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Lucas',
                    style: AppTheme.textStyles.title
                        .copyWith(fontSize: 16, color: AppTheme.colors.primary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Sarandi - 25 de Novembro de 2021',
                    style: AppTheme.textStyles.title
                        .copyWith(fontSize: 11, color: AppTheme.colors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        color: AppTheme.colors.primary,
        backgroundColor: AppTheme.colors.secondaryColor,
        animationCurve: Curves.easeInOut,
        items: [
          Icon(
            Icons.home_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
