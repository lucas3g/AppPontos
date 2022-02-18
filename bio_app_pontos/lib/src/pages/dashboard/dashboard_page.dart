import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/historico/historico_widget.dart';
import 'package:bio_app_pontos/src/pages/dashboard/localization/localization_widget.dart';
import 'package:bio_app_pontos/src/pages/dashboard/pontos/pontos_widget.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
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
      backgroundColor: AppTheme.colors.backgroundPrimary,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bem-Vindo',
                          style: AppTheme.textStyles.titleNome,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lucas Emanuel Silva dos Santos Paulo',
                          style: AppTheme.textStyles.titleNome,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${dataHoje.DiaMesAno()}',
                          style: AppTheme.textStyles.titleNome,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics:
                  currentIndex == 2 ? NeverScrollableScrollPhysics() : null,
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
