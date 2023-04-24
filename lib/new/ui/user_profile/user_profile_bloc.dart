import 'dart:io';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/repositories/Auth_repo.dart';

class UserProfileBloc extends BaseBloc {
  UserProfileBloc(BaseView view) : super(view);

  AuthRepo authRepo = AuthRepo();

  Future<bool> updateProfile(UserDataModel userData,
      {File? selectedImage}) async {
    try {
      view.showProgress();
      UserDataModel? response =
          await authRepo.updateProfile(userData, selectedImage: selectedImage);

      view.hideProgress();
      if (response != null) {
        UserDataModel? actualUser = AppCache.instance.getUserModel();
        if (response.data!.height!.isNotEmpty)
          actualUser!.data!.height = response.data!.height;

        if (response.data!.weight!.isNotEmpty)
          actualUser!.data!.weight = response.data!.weight;

        if (response.data!.age!.isNotEmpty)
          actualUser!.data!.age = response.data!.age;

        if (response.data!.diseases!.isNotEmpty)
          actualUser!.data!.diseases = response.data!.diseases;

        if (response.data!.photo!.isNotEmpty)
          actualUser!.data!.photo = response.data!.photo;

        if (response.data!.gender!.isNotEmpty)
          actualUser!.data!.gender = response.data!.gender;

        if (response.data!.insuranceCompany!.isNotEmpty)
          actualUser!.data!.insuranceCompany = response.data!.insuranceCompany;

        if (response.data!.nationalId!.isNotEmpty)
          actualUser!.data!.nationalId = response.data!.nationalId;

        if (response.data!.medicines!.isNotEmpty)
          actualUser!.data!.medicines = response.data!.medicines;

        AppCache.instance.setUserModel(actualUser!);
        return true;
      }
    } catch (error) {
      handleError(error);
    }
    return false;
  }

  @override
  void onDispose() {}
}
