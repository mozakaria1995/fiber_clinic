class LoginRequestModel {
  String? phone;
  String? password;

  LoginRequestModel({this.phone, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
}
