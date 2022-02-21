import 'package:bio_app_pontos/src/pages/dashboard/dashboard_page.dart';
import 'package:bio_app_pontos/src/pages/login/login_page.dart';
import 'package:bio_app_pontos/src/pages/register/register_page.dart';
import 'package:bio_app_pontos/src/pages/splash/splash_page.dart';
import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Constants.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: AppTheme.colors.primary),
      title: 'Bio - CashBack',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashBoardPage(),
      },
    );
  }
}
