import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:upgrader/upgrader.dart';
import 'new/cache/app_cache.dart';
import 'new/cache/notification_handler.dart';
import 'new/ui/doctor_details/doctor_details_screen.dart';
import 'new/ui/intro_video/video_screen.dart';
import 'new/ui/login/login_screen.dart';
import 'new/ui/splash_screen/splash_screen.dart';
import 'new/utils/resoures/theme_manager.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  AppCache.instance.init().then((value) {
    Firebase.initializeApp().then((value) async {

      NotificationHandler.instance.init().then((_) async {
        runApp(MyApp());
      });
    });
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      child: MaterialApp(
        title: 'Doctor',
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: getApplicationTheme(),
        initialRoute: "/",
        builder: EasyLoading.init(builder: BotToastInit()),
        debugShowCheckedModeBanner: false,
        home: UpgradeAlert(

            child: SplashScreen())
      ),
    );
  }


}
