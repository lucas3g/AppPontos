import 'dart:async';

import 'package:bio_app_pontos/app_widget.dart';
import 'package:bio_app_pontos/src/configs/app_settings.dart';
import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      GetIt getIt = GetIt.I;
      getIt.registerSingleton<AppSettings>(AppSettings());
      getIt.registerSingleton<RegisterController>(RegisterController());
      getIt.registerSingleton<LoginController>(LoginController());

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
        ),
      );
      runApp(AppWidget());
    },
    (error, st) => print(error),
  );
}
