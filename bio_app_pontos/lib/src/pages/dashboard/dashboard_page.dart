import 'package:bio_app_pontos/src/configs/global_settings.dart';
import 'package:bio_app_pontos/src/models/user_model.dart';
import 'package:bio_app_pontos/src/pages/dashboard/config/config_page.dart';
//import 'package:bio_app_pontos/src/pages/dashboard/localization/localization_widget.dart';
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
  late PageController controllerPage;
  late int currentIndex = 0;
  late UserModel? user;
  final DateTime dataHoje = DateTime.now();
  late bool tapped = false;

  @override
  void initState() {
    super.initState();
    controllerPage = PageController(initialPage: currentIndex);
    user = GlobalSettings().appSetting.user;
  }

  void onPageChanged(index) {
    if (!tapped)
      setState(() {
        currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: context.screenHeight * 0.15,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    context.image_path,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bem-Vindo',
                        style: AppTheme.textStyles.titleNome,
                      ),
                      SizedBox(height: 10),
                      Text(
                        user!.nome ?? '',
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
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: onPageChanged,
              physics:
                  currentIndex == 1 ? NeverScrollableScrollPhysics() : null,
              controller: controllerPage,
              children: [
                PontosWidget(),
                //HistorioWidget(),
                //LocalizationWidget(),
                ConfigPage(),
              ],
            ),
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: AppTheme.colors.primary,
      //         ),
      //         child: Text('Drawer Header'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        color: AppTheme.colors.primary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        items: [
          Icon(
            Icons.home_rounded,
            color: Colors.white,
          ),
          // Icon(
          //   Icons.list,
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.location_on,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.settings_rounded,
            color: Colors.white,
          ),
        ],
        onTap: (index) async {
          tapped = true;
          setState(() {});
          currentIndex = index;
          await controllerPage.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          tapped = false;
          setState(() {});
        },
      ),
    );
  }
}
