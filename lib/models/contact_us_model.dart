class ContactUsModel {
  int? id;
  String? phone;
  String? locationUrl;
  String? address;
  String? email;
  String? whatsapp;
  String? facebookUrl;

  ContactUsModel(
      {this.id,
      this.phone,
      this.locationUrl,
      this.address,
      this.email,
      this.whatsapp,
      this.facebookUrl});

  factory ContactUsModel.successfromJson(Map<String, dynamic> json) {
    return ContactUsModel(
        id: json['id'],
        phone: json['phone'],
        locationUrl: json['google_map_location_url'],
        address: json['address'],
        email: json['email'],
        whatsapp: json['whatsapp'],
        facebookUrl: json['facebook']);
  }
}
