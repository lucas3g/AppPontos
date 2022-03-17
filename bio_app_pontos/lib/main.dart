import 'dart:async';

import 'package:bio_app_pontos/app_widget.dart';
import 'package:bio_app_pontos/src/configs/app_settings.dart';
import 'package:bio_app_pontos/src/controllers/configuracao/config_controller.dart';
import 'package:bio_app_pontos/src/controllers/forgot_password/forgot_password_controller.dart';
import 'package:bio_app_pontos/src/controllers/historico/historico_controller.dart';
import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/maps/maps_controller.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_controller.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:bio_app_pontos/src/firebase_messaging/custom_firebase_messaging.dart';
import 'package:bio_app_pontos/src/services/check_internet_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting();

      final checkInternetService = CheckInternetService();

      if (await checkInternetService.haveInternet()) {
        await Firebase.initializeApp();

        await CustomFirebaseMessaging().inicialize();
      }

      GetIt getIt = GetIt.I;
      getIt.registerSingleton<AppSettings>(AppSettings());
      getIt.registerSingleton<RegisterController>(RegisterController());
      getIt.registerSingleton<LoginController>(LoginController());
      getIt.registerSingleton<ConfigController>(ConfigController());
      getIt.registerSingleton<MapsController>(MapsController());
      getIt.registerSingleton<ForgotPasswordController>(
          ForgotPasswordController());
      getIt.registerSingleton<PontosPromocoesController>(
          PontosPromocoesController());
      getIt.registerSingleton<HistoricoController>(HistoricoController());

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
