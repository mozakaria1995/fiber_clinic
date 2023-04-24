import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/repositories/Auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class ForgetPasswordBloc extends BaseBloc {
  ForgetPasswordBloc(BaseView view) : super(view);

  AuthRepo authRepo = AuthRepo();


  Future<bool> forgetPassword(String email) async {
    try {
      view.showProgress();
      Map<String,dynamic> response = await authRepo.forgetPassword(email);

      view.hideProgress();
      print(response);
      if (response["msg"] == "Reset password link sent on your email .") {
        return true;
      }
    } catch (error) {
      view.hideProgress();

      handleError(error);
      return false;
    }
    return false;
  }

  @override
  void onDispose() {
    authRepo.dispose();
  }
}
