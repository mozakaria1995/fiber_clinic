class LoginResponseModel {
  String? token;
  Map<String, dynamic>? userData;
  String? error;
  LoginResponseModel();

  LoginResponseModel.successFromJson(Map<String, dynamic> json) {
    token = json['data']['token'];
    userData = json['data'];
  }

  LoginResponseModel.errorFromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

}
