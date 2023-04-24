class OtpModel {
  String? phoneNumber;
  String? otp;

  OtpModel({ this.phoneNumber,  this.otp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['PhoneNumber'];
    otp = json['Otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PhoneNumber'] = this.phoneNumber;
    data['Otp'] = this.otp;
    return data;
  }
}