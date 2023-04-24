class ReservationModel {
  int? id;
  String? title;
  String? description;
  String? photo;
  String? icon;
  String? price;
  String? upcomingSchedule;

  ReservationModel(
      {this.id,
        this.title,
        this.description,
        this.photo,
        this.icon,
        this.price,
        this.upcomingSchedule});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    icon = json['icon'];
    price = json['price'];
    upcomingSchedule = json['upcoming_schedule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['upcoming_schedule'] = this.upcomingSchedule;
    return data;
  }
}