import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/repositories/Auth_repo.dart';
import 'package:auth_manager/new/utils/local_auth_manger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends BaseBloc {
  LoginBloc(BaseView view) : super(view);

  AuthRepo loginRepo = AuthRepo();

  Future<bool> requestLogin(String phone, String password) async {
    try {
      view.showProgress();
      UserDataModel? response =
          await loginRepo.loginRequest(phone: phone, password: password);

      view.hideProgress();
      if (response != null) {
        AppCache.instance
            .setStringForKey(response.data!.token!, AppCache.keyToken);
        AppCache.instance.setStringForKey(phone, AppCache.phone);
        AppCache.instance.setStringForKey(password, AppCache.password);
        AppCache.instance.setUserModel(response);

        return true;
      }
    } catch (error) {
      handleError(error);
    }
    return false;
  }

  Future<bool> requestSocialSignIn(
      {required UserCredential userCredential, required String socialType}) async {
    try {
      view.showProgress();

      final UserDataModel? response = await loginRepo.socialSignInRequest(
          socialId: userCredential.user!.uid, socialType: socialType);

      view.hideProgress();
      if (response != null) {
        AppCache.instance
            .setStringForKey(response.data!.token!, AppCache.keyToken);
        // AppCache.instance.setStringForKey(phone, AppCache.phone);
        // AppCache.instance.setStringForKey(password, AppCache.password);
        AppCache.instance.setUserModel(response);

        return true;
      }
    } catch (error) {
      handleError(error);
    }
    return false;
  }

  Future<bool> checkFingerPrintIfAvailable() async {
    final List<BiometricType> availableBiometrics =
        await LocalAuthApi.getBiometrics();

    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      if (await LocalAuthApi.authenticate()) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }

  Future<UserCredential> signInWithGoogle() async {
    return await loginRepo.signInWithGoogle();
  }
  Future<UserCredential?> signInWithApple() async {
    return await loginRepo.signInWithApple();
  }

  @override
  void onDispose() {
    loginRepo.dispose();
  }
}
