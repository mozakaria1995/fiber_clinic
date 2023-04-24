class ArticleListModel {
  List<ArticleModel>? data;

  ArticleListModel({this.data});

  ArticleListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ArticleModel>[];
      json['data'].forEach((v) {
        data!.add(new ArticleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleModel {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? blogTypeId;

  ArticleModel({this.id, this.title, this.description, this.photo, this.blogTypeId});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    blogTypeId = json['blog_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['blog_type_id'] = this.blogTypeId;
    return data;
  }
}