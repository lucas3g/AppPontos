import 'dart:async';

import 'package:bio_app_pontos/app_widget.dart';
import 'package:bio_app_pontos/src/configs/app_settings.dart';
import 'package:bio_app_pontos/src/controllers/historico/historico_controller.dart';
import 'package:bio_app_pontos/src/controllers/login/login_controller.dart';
import 'package:bio_app_pontos/src/controllers/pontos_promocoes/pontos_promocoes_controller.dart';
import 'package:bio_app_pontos/src/controllers/register/register_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      initializeDateFormatting();

      GetIt getIt = GetIt.I;
      getIt.registerSingleton<AppSettings>(AppSettings());
      getIt.registerSingleton<RegisterController>(RegisterController());
      getIt.registerSingleton<LoginController>(LoginController());
      getIt.registerSingleton<PontosPromocoesController>(
          PontosPromocoesController());
      getIt.registerSingleton<HistoricoController>(HistoricoController());

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
        ),
      );

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      runApp(AppWidget());
    },
    (error, st) => print(error),
  );
}
