import 'package:auth_manager/new/model/prescription_model.dart';
import 'package:auth_manager/new/model/reservation_response_model.dart';

class AllPreviousReservationsResponse {
  List<PreviousReservations>? previousReservations;

  AllPreviousReservationsResponse({this.previousReservations});

  AllPreviousReservationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      previousReservations = <PreviousReservations>[];
      json['data'].forEach((v) {
        previousReservations!.add(new PreviousReservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previousReservations != null) {
      data['data'] = this.previousReservations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class PreviousReservations {
  int? id;

  Service? service;
  String? price;
  String? date;
  String? isRated;
  String? rate;
  String? review;
  List<FileItem>? prescriptions;
  List<FileItem>? files;
  String? status;

  PreviousReservations(
      {this.id,

        this.service,
        this.price,
        this.date,
        this.files,
        this.isRated,
        this.rate,
        this.review,
        this.prescriptions,
        this.status});

  PreviousReservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    price = json['price'];
    date = json['date'];
    isRated = json['is_rated'];
    rate = json['rate'];
    review = json['review'];
    if (json['prescriptions'] != null) {
      prescriptions = <FileItem>[];
      json['prescriptions'].forEach((v) {
        prescriptions!.add(new FileItem.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <FileItem>[];
      json['files'].forEach((v) {
        files!.add(new FileItem.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['price'] = this.price;
    data['date'] = this.date;
    data['is_rated'] = this.isRated;
    data['rate'] = this.rate;
    data['review'] = this.review;
    if (this.prescriptions != null) {
      data['prescriptions'] = this.prescriptions!;
    }
    if (this.files != null) {
      data['files'] = this.files!;
    }
    data['status'] = this.status;
    return data;
  }
}