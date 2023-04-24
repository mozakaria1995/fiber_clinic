import 'package:auth_manager/new/model/upcoming_schedule_model.dart';

// return list of reservations
class ReservationsResponse {
  List<ReservationModel>? data;

  ReservationsResponse({this.data});

  ReservationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReservationModel>[];
      json['data'].forEach((v) {
        data!.add(new ReservationModel.fromJson(v));
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

// return single reservation
class ReservationResponse {
  ReservationModel? data;

  ReservationResponse({this.data});

  ReservationResponse.fromJson(Map<String, dynamic> json) {
    data =  ReservationModel.fromJson(json['data']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReservationModel {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? icon;
  String? price;
  int? hasConsultation;
  List<Categories>? categories;


  ReservationModel(
      {this.id,
        this.title,
        this.description,
        this.photo,
        this.icon,
        this.price,
        this.hasConsultation,
        this.categories});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    icon = json['icon'];
    price = json['price'];
    hasConsultation = json["has_consultation"];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data["has_consultation"] = this.hasConsultation;
    data['categories'] = this.categories;
    return data;
  }
}