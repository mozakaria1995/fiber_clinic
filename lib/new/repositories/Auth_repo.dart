import 'dart:io';

import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthRepo extends BaseRepo {
  //TODO
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    await GoogleSignIn().signOut();
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<UserCredential?> signInWithApple() async {
    final res = await TheAppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    if(res.status == AuthorizationStatus.authorized) {
      final AppleIdCredential? appleIdCredential = res.credential;
      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');

      final credential = oAuthProvider.credential(

          idToken: String.fromCharCodes(appleIdCredential?.identityToken ?? []),
          accessToken:
          String.fromCharCodes(appleIdCredential?.authorizationCode ?? []));

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    }
    return null ;
  }

  Future<UserDataModel?> loginRequest(
      {required String phone, required String password}) {
    return networkManager.post<UserDataModel>(Endpoints.LOGIN_URL, body: {
      "phone": phone,
      "password": password,
      "fcm_token": AppCache.instance.getStringForKey(AppCache.fcmToken),
    });
  }

  Future<UserDataModel?> socialSignInRequest(
      {required String socialId, required String socialType}) {
    return networkManager
        .post<UserDataModel>(Endpoints.SOCIAL_LOGIN_URL, body: {
      "social_id": socialId,
      "social_type": socialType,
      "fcm_token": AppCache.instance.getStringForKey(AppCache.fcmToken),
    });
  }

  Future<UserDataModel?> socialRegisterRequest(Map<String, dynamic> body) {
    return networkManager.post<UserDataModel>(Endpoints.SOCIAL_REGISTER_URL,
        body: body);
  }

  Future<bool?> changePasswordRequest(
      {required String oldPassword,
      required String newPassword,
      required String newPasswordConfirmation}) {
    return networkManager.post<bool>(Endpoints.UPDATE_PASSWORD_URL, body: {
      "old_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation
    });
  }

  Future<UserDataModel?> registerRequest(Map<String, dynamic> body) {
    return networkManager.post<UserDataModel>(Endpoints.REGISTER_URL,
        body: body);
  }

  Future forgetPassword(String email) {
    return networkManager.post(Endpoints.FORGET_PASSWORD_URL, body: {
      "email": email,
    });
  }

  Future<UserDataModel?> updateProfile(UserDataModel userData,
      {File? selectedImage}) async {
    if (selectedImage != null) {
      String fileName = selectedImage.path.split('/').last;
      final multiPartFile = {
        "photo": await MultipartFile.fromFile(selectedImage.path,
            filename: fileName),
      };
      UserDataModel? response = await networkManager.uploadFile<UserDataModel>(
          Endpoints.UPDATE_PROFILE_PIC, multiPartFile);
      if (response!.data!.photo != null) {
        userData.data!.photo = response.data!.photo;
      }
    }

    return networkManager.post(Endpoints.UPDATE_PROFILE_USER,
        body: userData.data!.updateProfileBody());
  }
}
