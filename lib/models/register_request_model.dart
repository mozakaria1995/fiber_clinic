class RegisterRequestModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? password;
  String? passwordConfirmation;

  RegisterRequestModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
