import 'dart:convert';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  static AppCache get instance {
    return _instance;
  }

  SharedPreferences? _prefs;

  static final String keyUser = "userModel";
  static final String keyToken = "token";
  static final String fcmToken = "fcmToken";
  static final String clinicInfo = "clinicInfo";
  static final String phone = "email";
  static final String password = "password";

  AppCache._private();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setUserModel(UserDataModel model)async {
    //if (model == null) return;
    String json = jsonEncode(model.toJson());
    await _prefs!.setString(keyUser, json);
    setStringForKey(model.data!.token, keyToken);
  }

  UserDataModel? getUserModel() {
    String? json = _prefs!.getString(keyUser);
    return json == null ? null : UserDataModel.fromJson(jsonDecode(json));
  }

  Future<void> logout() async {
    await _prefs!.remove(keyUser);
    await _prefs!.remove(keyToken);
   // await _prefs!.remove(fcmToken);
   // await _prefs!.remove(clinicInfo);
  }


  void setStringForKey(String? string, String key) async{
    if (string == null) return;
    await  _prefs!.setString(key, string);
  }


  String? getStringForKey(String key) {
    String? token = _prefs!.get(key) as String?;
    return token;
  }

  void setClinicInfo(ClinicInfoModel? clinic) async{
    if (clinic == null) return;
    String json = jsonEncode(clinic.toJson());
    await _prefs!.setString(clinicInfo, json);
  }

  ClinicInfoModel? getClinicInfo() {
    String? json = _prefs!.getString(clinicInfo);
    return json == null ? null : ClinicInfoModel.fromJson(jsonDecode(json));
  }

}
