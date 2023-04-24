import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/models/login_request_model.dart';
import 'package:auth_manager/models/register_request_model.dart';
import 'package:auth_manager/models/user_model.dart';
import 'package:auth_manager/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:auth_manager/core/cache_manager.dart';

class LoginController extends GetxController with CacheManager {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager = Get.find();
  UserModel? user;

  Map<String, dynamic>? fieldErrors;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
  }

  Future<void> loginUser(String phone, String password) async {
    EasyLoading.show();
    try {
      final response = await _loginService
          .fetchLogin(LoginRequestModel(phone: phone, password: password));

      if (response != null) {
        if (response.error == null) {
          /// Set isLogin to true
          final userData = response.userData;
          if (userData != null) {
            user = UserModel(
                id: userData['id'],
                phone: userData['phone'],
                firstName: userData['first_name'],
                lastName: userData['last_name'],
                token: userData['token'],
                photo: userData['photo']);
            _authManager.login(response.token, user!);
          }
        } else {
          Get.defaultDialog(
              middleText: response.error!,
              textConfirm: 'OK',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
              });
        }
      } else {
        /// Show user a dialog about the error response
        Get.defaultDialog(
            middleText: 'User not found!',
            textConfirm: 'OK',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    } catch (e) {
      Get.defaultDialog(
          middleText: e.toString(),
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> registerUser(String firstName, String lastName, String phone,
      String password, String passwordConfirmation) async {
    EasyLoading.show();
    try {
      final response = await _loginService.fetchRegister(RegisterRequestModel(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          password: password,
          passwordConfirmation: passwordConfirmation));

      if (response != null) {
        if (!response.hasError) {
          if (response.token != null) {
            final userData = response.userData;
            if (userData != null) {
              user = UserModel(
                  id: userData['id'],
                  phone: userData['phone'],
                  firstName: userData['first_name'],
                  lastName: userData['last_name'],
                  token: userData['token'],
                  photo: userData['photo']);
              _authManager.login(response.token, user!);
            }
          }
        } else {
          fieldErrors = response.error;
        }

        // _authManager.login(response.token);
      } else {
        /// Show user a dialog about the error response
        Get.defaultDialog(
            middleText: 'Register Error',
            textConfirm: 'Try Again',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Register Error',
          middleText: e.toString(),
          textConfirm: 'Try Again',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> changePassword(String oldPassowrd, String newPassword,
      String newPasswordConfirmation) async {
    EasyLoading.show();
    try {
      final token = getToken();
      if (token != null) {
        final response = await _loginService.changePassword(
            token, oldPassowrd, newPassword, newPasswordConfirmation);
        if (response == true) {
          /// Set isLogin to true
          Get.defaultDialog(
              middleText: "Password Changed Successfully",
              textConfirm: 'OK',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                Get.back();
              });
        } else {
          Get.defaultDialog(
              middleText: "There is a problem in changing password",
              textConfirm: 'Try Again',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
              });
        }
      }
    } catch (e) {
      Get.defaultDialog(
          middleText: "There is a problem in changing password",
          textConfirm: 'Try Again',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    } finally {
      EasyLoading.dismiss();
    }
  }

  void logout() {
    _authManager.logOut();
  }
}
