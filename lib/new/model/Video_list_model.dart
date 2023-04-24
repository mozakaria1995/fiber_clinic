class VideoListModel {
  List<VideoModel>? data;

  VideoListModel({this.data});

  VideoListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VideoModel>[];
      json['data'].forEach((v) {
        data!.add(new VideoModel.fromJson(v));
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

class VideoModel {
  int? id;
  String? title;
  String? description;
  String? path;
  String? photo;

  VideoModel({this.id, this.title, this.description, this.path, this.photo});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    path = json['path'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['path'] = this.path;
    data['photo'] = this.photo;
    return data;
  }
}