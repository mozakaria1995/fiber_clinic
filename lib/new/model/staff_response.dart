class StaffResponse {
  List<StaffMember>? staffList;

  StaffResponse({this.staffList});

  StaffResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      staffList = <StaffMember>[];
      json['data'].forEach((v) {
        staffList!.add(new StaffMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.staffList != null) {
      data['data'] = this.staffList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaffMember {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? specialty;
  String? description;

  StaffMember(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.image,
        this.specialty,
        this.description});

  StaffMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    specialty = json['spcialty'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['spcialty'] = this.specialty;
    data['description'] = this.description;
    return data;
  }
}

class StaffMemberResponse {
  StaffMember? data;

  StaffMemberResponse({this.data});

  StaffMemberResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new StaffMember.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}