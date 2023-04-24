

import 'package:auth_manager/config/config.dart';
import 'package:auth_manager/models/schedule_reservation_model.dart';
import 'package:auth_manager/models/service_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../new/network/Endpoints.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class ReservationService extends GetConnect {
  final String domainUrl = Endpoints.BASE_URL;

  Future<List<ServiceModel>?> getReservationServices() async {
    String url = domainUrl + "reservationServices";
    final response = await get(url);

    if (response.statusCode == HttpStatus.ok) {
      var body = response.body;
      if (body['data'].isNotEmpty) {
        var data = body['data'];
        List<ServiceModel>? services;
        services = List.from(data.map((m) => ServiceModel.successfromJson(m)));
        return services;
      }
    }
    return null;
  }

  Future<List<ScheduleReservationModel>?> getScheduleReservation(
      int serviceId) async {
    try {
      String url = domainUrl + "reservationServices/$serviceId";
      final response = await get(url);

      if (response.statusCode == HttpStatus.ok) {
        var body = response.body;
        print(body);

        if (body['data'].isNotEmpty) {
          var data = body['data']['upcoming_schedule'];
          List<ScheduleReservationModel>? schedule;
          schedule = List.from(
              data.map((m) => ScheduleReservationModel.successfromJson(m)));
          return schedule;
        }
      }
      return null;
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> reserveService(
      int serviceId, int userId, String date, String time) async {
    try {
      Map<String, dynamic> jsonMap = {
        "user_id": userId,
        "service_id": serviceId,
        "date": date,
        "time": time
      };
      print(jsonMap);
      String url = domainUrl + "userReservations";
      final response = await post(url, jsonMap);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      return false;
    } catch (e) {
      throw (e);
    }
  }
}
