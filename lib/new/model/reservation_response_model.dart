class ReservationResponseModel {
  ResponseData? responseData;

  ReservationResponseModel({this.responseData});

  ReservationResponseModel.fromJson(Map<String, dynamic> json) {
    responseData = json['data'] != null ? new ResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responseData != null) {
      data['data'] = this.responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  int? id;
  User? user;
  Service? service;
  String? price;
  String? date;
  String? time;
  int? paymentType;

  ResponseData(
      {this.id,
        this.user,
        this.service,
        this.price,
        this.date,
        this.time,
        this.paymentType});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    price = json['price'];
    date = json['date'];
    time = json['time'];
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['price'] = this.price;
    data['date'] = this.date;
    data['time'] = this.time;
    data['payment_type'] = this.paymentType;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? photo;
  String? whatsapp;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.photo,
        this.whatsapp});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}

class Service {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? icon;
  String? price;
  List<Null>? upcomingSchedule;

  Service(
      {this.id,
        this.title,
        this.description,
        this.photo,
        this.icon,
        this.price,
        this.upcomingSchedule});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    icon = json['icon'];
    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['icon'] = this.icon;
    data['price'] = this.price;

    return data;
  }
}