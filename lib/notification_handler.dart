import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class NotificationHandler {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final androidPlatfromChannelSpecifics = const AndroidNotificationDetails(
    'notification_channel',
    'location-bg',
    priority: Priority.high,
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    enableLights: true,
    ticker: 'ticker',
  );
  final iOSPlatfromChannelSpecifics = const DarwinNotificationDetails(
    subtitle: 'Location Fetched',
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    badgeNumber: 20,
  );

  NotificationHandler() {
    const initialisationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initialisationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        log(details.toString());
        log('Did recieve notification');
      },
    );
  }

  Future showNotification(String position) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatfromChannelSpecifics,
        iOS: iOSPlatfromChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'Location Fetched', position, notificationDetails,
        payload: 'Test');
  }

  Future sceduleNotification() async {
    final NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatfromChannelSpecifics,
        iOS: iOSPlatfromChannelSpecifics);

    flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        'Periodic',
        'This is notification is displayed periodically',
        RepeatInterval.weekly,
        notificationDetails);

  }
}
