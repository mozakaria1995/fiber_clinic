class RegisterErrorResponse {
  Error? error;
  String? message;
  bool? success;

  RegisterErrorResponse({this.error, this.message, this.success});

  RegisterErrorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Error {
  List<String>? firstName;
  List<String>? lastName;
  List<String>? phone;

  Error({this.firstName, this.lastName, this.phone});

  Error.fromJson(Map<String, dynamic> json) {
    // firstName = json['first_name'].cast<String>();
    // lastName = json['last_name'].cast<String>();
    phone = json['phone'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    return data;
  }
}