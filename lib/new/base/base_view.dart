import 'package:flutter/material.dart';

abstract class BaseView {
  void showProgress();

  void hideProgress();

  Future<dynamic> navigateToReplacement(Widget screen);

  void showSuccessMsg(String? msg, {int duration});

  void showErrorMsg(String? msg);

  String localize(String key);
}
