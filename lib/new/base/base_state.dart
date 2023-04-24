import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bot_toast/bot_toast.dart';

//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'base_bloc.dart';
import 'base_view.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc>
    extends State<T> implements BaseView {
  CancelFunc? cancelFunc;
  bool _loaderVisible = false;
  late B bloc;
  //late FirebaseAnalyticsObserver observer;
  //late FirebaseAnalytics analytics;
  @override
  void initBloc();
  Widget buildWidget(BuildContext context);

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return _loaderVisible;
  }

  @override
  Future<dynamic> navigateToReplacement(Widget screen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (Route<dynamic> route) => false,
    );
  }

  // String getScreenName();

  /* Future<void> sendAnalyticsEvent(
      String eventName, Map<String, dynamic>? parameters) async {

    //  await analytics.logEvent(name: eventName, parameters: parameters,);
      print('${getScreenName()} Data sent');

  }*/

  /* Future<void> setCurrentScreen() async {
    if (getScreenName() != "") {
     // await analytics.setCurrentScreen(screenName: '${getScreenName()}', screenClassOverride: '${getScreenName()}',);
      print('${getScreenName()}:setCurrentScreen succeeded');
    }
  }*/

  @override
  void initState() {
    super.initState();
    //  analytics = FirebaseAnalytics();
    //  observer = FirebaseAnalyticsObserver(analytics: analytics);
    // setCurrentScreen();
    initBloc();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
    bloc.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Future<dynamic> navigateTo(Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  /* String locale() {
    return context.locale.languageCode;
  }

  static String getLocale(context) {
    return EasyLocalization.of(context).locale.languageCode;
  }

  void changeLocale() {
    if (locale() == null || locale() == 'en')
      context.locale = Locale('ar', 'EG');
    else
      context.locale = Locale('en', 'US');

    AppCache.instance
        .setLanguage(EasyLocalization.of(context).locale.languageCode);
  }
*/
  @override
  String localize(String key) {
    return 'r'; //tr(key);
  }

  void closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  void showProgress() {
    closeKeyboard();
    cancelFunc?.call();

    cancelFunc = BotToast.showLoading();
    _loaderVisible = true;
  }

  @override
  void hideProgress() {
    cancelFunc?.call();
    _loaderVisible = false;
  }

  @override
  void showSuccessMsg(String? msg, {int duration = 2}) {
    if (msg == null || msg.isEmpty) return;

    showToast(msg, FontAwesomeIcons.solidCheckCircle, Colors.green,duration: duration);
  }

  @override
  void showErrorMsg(String? msg) {
    if (msg == null || msg.isEmpty) return;

    showToast(
        msg, FontAwesomeIcons.exclamationTriangle, Color(0xFFF53A56));
  }

  void showToast(String msg, IconData icon, Color color, {int duration = 2}) {
    BotToast.showCustomText(
      duration:  Duration(seconds: duration),
      onlyOne: true,
      align: const Alignment(0, 0.8),
      toastBuilder: (_) => Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        clipBehavior: Clip.antiAlias,
        shape:
        RoundedRectangleBorder(borderRadius:  BorderRadius.circular(6)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(icon, color: color),
              SizedBox(width: 16),
              Flexible(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 15, color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showDialogToast(String msg, IconData icon, Color color) {
    BotToast.showAnimationWidget(
      toastBuilder: (_) => Center(child:SizedBox(
        child: Text(msg),
        width: 200,
        height: 150,
      ),),
      duration: Duration(seconds: 5),
      animationDuration: Duration(seconds: 3),
    );
  }
}
