class Categories {
  Categories({
    required this.id,
    required this.reservationServiceId,
    required this.name,
    required this.price,
    required this.numberSlotUnits,
    required this.numberCasesPerSlot,
    required this.active,
    required this.upcomingSchedule,
  });
  late final int id;
  late final String reservationServiceId;
  late final String name;
  late final String price;
  late final String numberSlotUnits;
  late final String numberCasesPerSlot;
  late final String active;
  late final List<UpcomingSchedule> upcomingSchedule;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['id'];
    reservationServiceId = json['reservation_service_id'];
    name = json['name'];
    price = json['price'];
    numberSlotUnits = json['number_slot_units'];
    numberCasesPerSlot = json['number_cases_per_slot'];
    active = json['active'];
    upcomingSchedule = List.from(json['upcoming_schedule']).map((e)=>UpcomingSchedule.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reservation_service_id'] = reservationServiceId;
    _data['name'] = name;
    _data['price'] = price;
    _data['number_slot_units'] = numberSlotUnits;
    _data['number_cases_per_slot'] = numberCasesPerSlot;
    _data['active'] = active;
    _data['upcoming_schedule'] = upcomingSchedule.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class UpcomingSchedule {
  UpcomingSchedule({
    required this.date,
    required this.availableSlots,
  });
  late final String date;
  late final List<AvailableSlots> availableSlots;

  UpcomingSchedule.fromJson(Map<String, dynamic> json){
    date = json['date'];
    availableSlots = List.from(json['available_slots']).map((e)=>AvailableSlots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['available_slots'] = availableSlots.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class AvailableSlots {
  AvailableSlots({
    required this.time,
    required this.reservationServiceDaySlotsIds,
  });
  late final String time;
  late final List<int> reservationServiceDaySlotsIds;

  AvailableSlots.fromJson(Map<String, dynamic> json){
    time = json['time'];
    reservationServiceDaySlotsIds = List.castFrom<dynamic, int>(json['reservation_service_day_slots_ids']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['reservation_service_day_slots_ids'] = reservationServiceDaySlotsIds;
    return _data;
  }
}