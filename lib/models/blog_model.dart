class BlogModel {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? type;

  BlogModel({this.id, this.title, this.description, this.photo, this.type});

  factory BlogModel.successfromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        photo: json['photo'],
        type: json['type']);
  }
}
