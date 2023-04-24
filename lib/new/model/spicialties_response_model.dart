class SpecialtiesResponse {
  List<Specialty>? specialtiesList;

  SpecialtiesResponse({this.specialtiesList});

  SpecialtiesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      specialtiesList = <Specialty>[];
      json['data'].forEach((v) {
        specialtiesList!.add(new Specialty.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specialtiesList != null) {
      data['data'] = this.specialtiesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specialty {
  int? id;
  String? title;
  String? sort;

  Specialty({this.id, this.title, this.sort});

  Specialty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sort'] = this.sort;
    return data;
  }
}