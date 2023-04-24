import 'dart:async';

import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/ui/intro_video/video_screen.dart';
import 'package:auth_manager/new/ui/landing/landing_screen.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';
import 'package:auth_manager/new/ui/splash_screen/splash_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen, SplashBloc>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _opacityController;

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => IntroVideo(
                  videoUrl:
                  AppCache.instance.getClinicInfo()!.data!.introVideo!,
                  onButtonTapped: () {
                    UserDataModel? userModel = AppCache.instance.getUserModel();
                    if (userModel != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()),
                          (route) => false);
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    }
                  },
                  buttonText: 'تخطي',
                )),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    bloc.getClinicInfo((loaded) {
      if (loaded) {
        Timer(Duration(seconds: 4), navigationPage);
      }
    });

    _opacityController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: .3,
        upperBound: 1.0);
    _opacityController!.forward();

    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controller!.forward();

    _controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    this._opacityController!.dispose();
    this._controller!.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorManager.primary, Colors.white],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text("© 2022 Fiber Clinics . All Rights Reserved.",
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: AnimatedBuilder(
                    animation: _opacityController!,
                    builder: (context, child) {
                      return Opacity(
                          opacity: _opacityController!.value,
                          child: ScaleTransition(
                              scale: Tween(begin: .85, end: .9).animate(
                                CurvedAnimation(
                                    parent: _controller!,
                                    curve: Curves.easeInOut),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.4),
                                child: Image.asset(
                                  "assets/images/logo.jpeg",
                                  width: size.width * 0.8,
                                ),
                              )));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initBloc() {
    bloc = SplashBloc(this);
  }
}
