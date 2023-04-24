import 'dart:io';

import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  showBadge: true,
  importance: Importance.high,
  description: 'This channel is used for important notifications.',
);
var androidInitializations = AndroidInitializationSettings('@mipmap/ic_launcher');

var iosInitializations = DarwinInitializationSettings(
  defaultPresentAlert: true,
  defaultPresentBadge: true,
  defaultPresentSound: true,
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  var initializationSettings = InitializationSettings(
      android: androidInitializations, iOS: iosInitializations);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  if (message != null) {
    print('Handling a background message ${message.messageId}');
    print(message.data);
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true),
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            enableLights: true,
            enableVibration: true,
            playSound: true,
            icon: android?.smallIcon,
            channelDescription: channel.description,
          ),
        ));
  }
}

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._private();

  static NotificationHandler get instance {
    return _instance;
  }

  NotificationHandler._private();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    try {
      await initFirebaseNotifications();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> initFirebaseNotifications() async {
    var initializationSettings = InitializationSettings(
      android: androidInitializations,
      iOS: iosInitializations,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (Platform.isIOS) {
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    final token = await getToken();
    print("\n");
    print(token);
    print("\n");
    AppCache.instance.setStringForKey(token, AppCache.fcmToken);
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null ) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: const DarwinNotificationDetails(

                presentAlert: true,
                presentBadge: true,
                sound: "default",
                presentSound: true,
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/ic_launcher'

              ),
            ));
      }
    });

    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
