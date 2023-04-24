class MyReservationsModel {
  List<Reservation>? reservationsList;

  MyReservationsModel({this.reservationsList});

  MyReservationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      reservationsList = <Reservation>[];
      json['data'].forEach((v) {
        reservationsList!.add(new Reservation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservationsList != null) {
      data['data'] = this.reservationsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservation {
  int? id;
  Service? service;
  String? date;
  String? dateInDays;
  String? dateInHours;
  String? dateInMints;
  String? time;
  String? toTime;
  String? paymentType;
  String? paymentStatus;
  bool? dateInDaysStatus;
  bool? dateInHoursStatus;

  Reservation({
    this.id,
    this.service,
    this.date,
    this.time,
    this.toTime,
    this.paymentType,
    this.paymentStatus,
    this.dateInMints,
    this.dateInDaysStatus,
    this.dateInHoursStatus,
    this.dateInDays,
    this.dateInHours,
  });

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'] != null ? new Service.fromJson(json['service']) : null;

    date = json['date'];
    time = json['time'];
    dateInDaysStatus = DateTime.parse(json['date']).difference(DateTime.now()).inDays >= 1;
    dateInHoursStatus = DateTime.parse(json['date']).difference(DateTime.now()).inHours >= 1;
    dateInDays = (DateTime.parse(json['date']).difference(DateTime.now()).inDays).toString() ;
    dateInHours = (DateTime.parse(json['date']).difference(DateTime.now()).inHours).toString();
    dateInMints= (DateTime.parse(json['date']).difference(DateTime.now()).inMinutes).toString();
    print("john here + " + dateInMints!) ;
    toTime = json['to_time'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['date'] = this.date;
    data['time'] = this.time;
    data['to_time'] = this.toTime;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class Service {
  int? id;
  String? title;

  Service({
    this.id,
    this.title,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
