class ReservationRequestModel {
  int? userId;
  int? serviceId;
  String? date;
  String? time;
  int? paymentType;
  int? reservationType;
  List? slotID;
  int? categoryId;
  ReservationRequestModel({this.categoryId,this.slotID,this.userId, this.serviceId, this.date, this.time, this.paymentType, this.reservationType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['reservation_service_day_slots_ids'] = this.slotID;
    data['reservation_service_category_id'] = this.categoryId;
    data['reservation_type'] = this.reservationType;
   data['payment_type'] = this.paymentType;
    return data;
  }
}