import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/repositories/Auth_repo.dart';

class RegisterBloc extends BaseBloc {
  RegisterBloc(BaseView view) : super(view);

  AuthRepo registerRepo = AuthRepo();

  Future<bool> registerRequest(Map<String, dynamic> body) async {
    try {
      view.showProgress();
      UserDataModel? response = await registerRepo.registerRequest(body);
      //print(response?.data!.token ?? "no value here");
      AppCache.instance
          .setStringForKey(response!.data!.token!, AppCache.keyToken);
      AppCache.instance.setUserModel(response);
      view.hideProgress();
      if (response != null) {
        return true;
      }
    } catch (error) {
      handleError(error);
    }
    return false;
  }
  Future<bool> socialRegisterRequest(Map<String, dynamic> body) async {
    try {
      view.showProgress();
      UserDataModel? response = await registerRepo.socialRegisterRequest(body);
      AppCache.instance
          .setStringForKey(response!.data!.token!, AppCache.keyToken);
      AppCache.instance.setUserModel(response);
      view.hideProgress();
      if (response != null) {
        return true;
      }
    } catch (error) {
      handleError(error);
    }
    return false;
  }

  @override
  void onDispose() {
    registerRepo.dispose();
  }
}
