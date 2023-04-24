import 'package:auth_manager/controllers/blogs_controller.dart';
import 'package:auth_manager/controllers/contact_us_controller.dart';
import 'package:auth_manager/controllers/reservation_controller.dart';
import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/views/login_view_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new/ui/landing/landing_screen.dart';

class SplashView extends StatelessWidget {
  final AuthenticationManager _authmanager = Get.find();

  Future<void> initializeSettings() async {
    await _authmanager.checkLoginStatus();

    Future.delayed(Duration(seconds: 0), () {
      Get.put(ReservationController());
      Get.put(ContactUsController());
      Get.put(BlogsController());
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingView();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else
            return Obx(() {
              return _authManager.isLogged.value ? LandingScreen() : LoginPage();
            });
        }
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/logo.jpeg")],
        ),
      ),
    ));
  }
}
