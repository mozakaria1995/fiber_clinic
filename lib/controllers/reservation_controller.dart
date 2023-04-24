import 'package:auth_manager/models/schedule_reservation_model.dart';
import 'package:auth_manager/models/service_model.dart';
import 'package:auth_manager/services/reservation_service.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {
  late final ReservationService _reservationService;

  Rxn<List<ServiceModel>> services = Rxn<List<ServiceModel>>();

  @override
  void onInit() {
    super.onInit();
    _reservationService = Get.put(ReservationService());
  }

  @override
  void onReady() async {
    services.value = await _reservationService.getReservationServices();
  }

  Future<List<ScheduleReservationModel>?> getSchedule(int serviceId) async {
    List<ScheduleReservationModel>? schedule;
    try {
      schedule = await _reservationService.getScheduleReservation(serviceId);
      return schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> reserveService(
      int serviceId, int userId, String date, String time) async {
   // List<ScheduleReservationModel>? schedule;
    try {
      return await _reservationService.reserveService(
          serviceId, userId, date, time);
    } catch (e) {
      rethrow;
    }
  }
}
