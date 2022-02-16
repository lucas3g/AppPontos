import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/historico/historico_widget.dart';
import 'package:bio_app_pontos/src/pages/dashboard/localization/localization_widget.dart';
import 'package:bio_app_pontos/src/pages/dashboard/pontos/pontos_widget.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:bio_app_pontos/src/utils/formatters.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final PageController controllerPage = PageController();
  late int currentIndex = 0;
  late UserModel? user;
  final DateTime dataHoje = DateTime.now();

  @override
  void initState() {
    super.initState();

    user = GlobalSettings().appSetting.user;
  }

  void pageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      currentIndex = index;
      controllerPage.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
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
          height: context.screenHeight * 0.27,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              Center(
                child: Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bem-Vindo',
                      style: AppTheme.textStyles.title.copyWith(
                          fontSize: 16, color: AppTheme.colors.primary),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FittedBox(
                      child: Text(
                        'Lucas Emanuel Silva ',
                        style: AppTheme.textStyles.title.copyWith(
                            fontSize: 16, color: AppTheme.colors.primary),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FittedBox(
                      child: Text(
                        'Sarandi - ${dataHoje.DiaMesAno()}',
                        style: AppTheme.textStyles.title.copyWith(
                            fontSize: 11, color: AppTheme.colors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            physics: currentIndex == 2 ? NeverScrollableScrollPhysics() : null,
            controller: controllerPage,
            onPageChanged: (index) {
              pageChanged(index);
            },
            children: [
              PontosWidget(),
              HistorioWidget(),
              LocalizationWidget(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        color: AppTheme.colors.primary,
        backgroundColor: Colors.transparent,
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
          Icon(
            Icons.location_on,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }
}
