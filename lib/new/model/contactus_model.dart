class ContactModel {
  Data? data;

  ContactModel({this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? phone;
  String? googleMapLocationUrl;
  String? address;
  String? email;
  String? whatsapp;
  String? facebook;

  Data(
      {this.id,
        this.phone,
        this.googleMapLocationUrl,
        this.address,
        this.email,
        this.whatsapp,
        this.facebook});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    googleMapLocationUrl = json['google_map_location_url'];
    address = json['address'];
    email = json['email'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['google_map_location_url'] = this.googleMapLocationUrl;
    data['address'] = this.address;
    data['email'] = this.email;
    data['whatsapp'] = this.whatsapp;
    data['facebook'] = this.facebook;
    return data;
  }
}