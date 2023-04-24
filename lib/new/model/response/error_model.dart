class ErrorModel {
  String ? name;
  String? message;
  int? statusCode ;
  String ?error;
  String? type ;

  ErrorModel({ this.name, this.message,this.statusCode,this.type,this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
    statusCode = json["statusCode"];
    type =json["type"];
    error =json["error"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    return data;
  }
}
