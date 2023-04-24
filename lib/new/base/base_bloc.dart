import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/response/error_response.dart';
import 'package:auth_manager/new/network/parser.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';
import 'package:dio/dio.dart';

import 'base_view.dart';

abstract class BaseBloc {
  BaseView view;

  BaseBloc(this.view);

  void handleUnauthorized() async {
    await AppCache.instance.logout();
    view.navigateToReplacement(LoginScreen());
  }

  void handleError(dynamic e) {
    String? msg;
    ErrorModel response;

    try {
      if (e is DioError && e.response != null) {
          response = Parser.parse<ErrorModel>(e.response!.data);
          msg = response.message![0];
        print(msg);
      } else {}
    } catch (err) {

    }

    onError(msg??"");
  }

  void onError(String msg) {
    view.hideProgress();
    view.showErrorMsg(msg);
  }

  void onDispose();
}
