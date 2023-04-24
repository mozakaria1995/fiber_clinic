class UserModel {
  int? id;
  String? phone;
  String? firstName;
  String? lastName;
  String? photo;
  String? token;

  UserModel(
      {required this.id,
      required this.phone,
      required this.firstName,
      required this.lastName,
      this.token,
      this.photo});
}
