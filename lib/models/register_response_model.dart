class RegisterResponseModel {
  int? id;
  String? phone;
  Map<String, dynamic>? error;
  bool? success;
  String? msg;
  String? token;
  bool hasError = false;
  Map<String, dynamic>? userData;

  RegisterResponseModel.successfromJson(Map<String, dynamic> json) {
    id = json['data']['id'];
    phone = json['data']['phone'];
    token = json['data']['token'];
    hasError = false;
    userData = json['data'];
  }

  RegisterResponseModel.errorfromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['message'];
    success = json['success'];
    hasError = true;
  }
}
