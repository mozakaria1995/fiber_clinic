
import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/repositories/Auth_repo.dart';

class ChangePasswordBloc extends BaseBloc {
  ChangePasswordBloc(BaseView view) : super(view);

  AuthRepo changePasswordRepo = AuthRepo();

  Future<bool> changePasswordRequest(String oldPassword, String newPassword,
      String newPasswordConfirmation) async {
    try {
      //print(loginRepo.requestLogin(email,password));
      view.showProgress();
      bool? response =
          await changePasswordRepo.changePasswordRequest(
              oldPassword: oldPassword,
              newPassword: newPassword,
              newPasswordConfirmation: newPasswordConfirmation);
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
    changePasswordRepo.dispose();
  }
}
