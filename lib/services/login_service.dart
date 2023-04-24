import 'dart:convert';

import 'package:auth_manager/config/config.dart';
import 'package:auth_manager/models/login_request_model.dart';
import 'package:auth_manager/models/login_response_model.dart';
import 'package:auth_manager/models/register_request_model.dart';
import 'package:auth_manager/models/register_response_model.dart';
import 'package:auth_manager/models/user_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:retry/retry.dart';

import '../new/network/Endpoints.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String domainUrl = Endpoints.BASE_URL;

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    String url = domainUrl + "auth/login";
    final response = await post(url, model.toJson());
    print("here res ${response.body}");

    if (response.statusCode == HttpStatus.badRequest) {
      return LoginResponseModel.errorFromJson(response.body);
    } else if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.successFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    String url = domainUrl + "auth/register";
    final response = await post(url, model.toJson());

    if (response.statusCode == HttpStatus.unprocessableEntity) {
      return RegisterResponseModel.errorfromJson(response.body);
    } else if (response.statusCode == HttpStatus.created) {
      return RegisterResponseModel.successfromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> changePassword(String token, String oldPassword,
      String newPassword, String newPasswordConfirmation) async {
    String url = domainUrl + "updatePassword";
    Map<String, String> jsonMap = {
      "old_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation
    };

    final response = await post(url, json.encode(jsonMap), headers: {
      'Authorization': 'Bearer $token',
    });

    print(response.body);

    if (response.statusCode == HttpStatus.badRequest) {
      return false;
    } else if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel?> getUser(String token) async {
    String url = domainUrl + "me";
    final r = RetryOptions(maxAttempts: 30);
    final response = await r.retry(
      () async {
        return await get(url, headers: {
          'Authorization': 'Bearer $token',
        }).timeout(Duration(seconds: 5));
      },
      retryIf: (e) => true,
    );

    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> body = response.body;
      if (body.containsKey("data")) {
        dynamic data = body['data'];
        if (data.isNotEmpty) {
          UserModel user = UserModel(
              id: data['id'],
              phone: data['phone'],
              firstName: data['first_name'],
              lastName: data['last_name']);
          return user;
        }
      }
    }
    return null;
  }
}
