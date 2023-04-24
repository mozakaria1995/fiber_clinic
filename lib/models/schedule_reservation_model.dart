class ScheduleReservationModel {
  String? date;
  List<dynamic>? slots;

  ScheduleReservationModel({
    this.date,
    this.slots,
  });

  factory ScheduleReservationModel.successfromJson(Map<String, dynamic> json) {
    return ScheduleReservationModel(
        date: json['date'], slots: json['available_slots']);
  }
}
