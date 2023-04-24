class ServiceModel {
  int? id;
  String? title;
  String? description;
  String? price;
  String? icon;
  String? photo;
  List<dynamic>? workingDays;

  ServiceModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.icon,
      this.photo,
      this.workingDays});

  factory ServiceModel.successfromJson(Map<String, dynamic> json) {
    return ServiceModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        icon: json['icon'],
        photo: json['photo'],
        workingDays: json['working_days']);
  }
}
