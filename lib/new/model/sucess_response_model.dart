class SuccessResponse {
  String? msg;
  String? fileUrl;

  SuccessResponse({this.msg, this.fileUrl});

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['file_url'] = this.fileUrl;
    return data;
  }
}