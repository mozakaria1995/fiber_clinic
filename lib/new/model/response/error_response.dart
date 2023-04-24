
class ErrorModel {
  bool? success;
  List<String>? message;

  ErrorModel({this.success, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}