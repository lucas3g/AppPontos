import 'package:bio_app_pontos/src/firebase_messaging/custom_local_notification.dart';
import 'package:bio_app_pontos/src/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;

  CustomFirebaseMessaging._internal(this._customLocalNotification);

  static final CustomFirebaseMessaging _singleton =
      CustomFirebaseMessaging._internal(CustomLocalNotification());
  factory CustomFirebaseMessaging() => _singleton;

  Future<void> inicialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(badge: true, sound: true);

    await FirebaseMessaging.instance.subscribeToTopic("all");

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _customLocalNotification.androidNotification(notification, android);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['goTO'] != null) {
        Constants.navigatorKey.currentState?.pushNamed(message.data['goTO']);
      }
    });
  }

  getTokenFirebase() async =>
      debugPrint(await FirebaseMessaging.instance.getToken());
}
