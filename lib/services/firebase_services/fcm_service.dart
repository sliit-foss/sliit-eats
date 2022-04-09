import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    'This channel is used for important notifications.',
    importance: Importance.max,
  );
  static Future initialize() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await listener();
      } else {
        print("Notification authorization denied");
      }
    } else {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      await listener();
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.notification!.title}");
  }

  static listener() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var initializationSettingsAndroid = AndroidInitializationSettings("ic_launcher");
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications', 'This channel is used for important notifications',
            importance: Importance.max, priority: Priority.high, showWhen: false);

        const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, platformChannelSpecifics, payload: 'item x');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
