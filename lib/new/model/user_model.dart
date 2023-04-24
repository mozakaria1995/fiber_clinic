class UserDataModel {
  Data? data;

  UserDataModel({this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? phone;
  String? photo;
  String? whatsapp;
  String? token;
  String? height;
  String? weight ;
  String? age ;
  String? diseases ;

  String? gender ;
  String? nationalId ;
  String? insuranceCompany ;
  String? medicines ;


  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.photo,
        this.whatsapp,
        this.height,
        this.weight,
        this.age,
        this.diseases,
        this.gender,
        this.insuranceCompany,
        this.medicines,
        this.nationalId,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    photo = json['photo'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    diseases = json['diseases'];
    whatsapp = json['whatsapp'];
    token = json['token'];

    gender = json["gender"];
    insuranceCompany = json["insurance_company"];
    nationalId = json["national_id"];
    medicines = json["medicines"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['whatsapp'] = this.whatsapp;
    data['token'] = this.token;

    data['height'] = this.height;
    data['weight'] = this.weight;
    data['age'] = this.age;
    data['diseases'] = this.diseases;

    data["gender"] = this.gender ;
    data["insurance_company"] = this.insuranceCompany;
    data["national_id"] = this.nationalId;
    data["medicines"] = this.medicines;

    return data;
  }

  Map<String, dynamic> updateProfileBody() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['photo'] = this.photo;
    data['age'] = this.age;
    data['diseases'] = this.diseases;
    data["gender"] = this.gender ;
    data["insurance_company"] = this.insuranceCompany;
    data["national_id"] = this.nationalId;
    data["medicines"] = this.medicines;
    return data;
  }


}