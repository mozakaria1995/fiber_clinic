import 'dart:io';

import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/all_prev_reservations_response.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/model/reservation_response_model.dart';
import 'package:auth_manager/new/model/sucess_response_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';
import 'package:dio/dio.dart';
String url="";
class ReservationRepo extends BaseRepo {
  late Dio dio;

  Future<ReservationsResponse?> getReservationsList() {
    return networkManager.get<ReservationsResponse>(Endpoints.RESERVATIONS);
  }

  Future getReservationById(int reservationId) async {
    final response = await networkManager.get("${Endpoints.SCHEDULED_RESERVATION}$reservationId");
    return ReservationModel.fromJson(response["data"]);
  }

  Future<MyReservationsModel?> getMyReservations() {
    return networkManager
        .get<MyReservationsModel>(Endpoints.GET_MY_RESERVATIONS);
  }

  //TODO
  Future<ReservationResponseModel?> reserveCashOnDeliverReservation(
      ReservationRequestModel requestModel) {
    print("XXX"+ requestModel.toJson().toString());
    return networkManager.post<ReservationResponseModel>(
        Endpoints.RESERVE_APPOINTMENT,
        body: requestModel.toJson());
  }


  Future reserveCreditReservation(

      ReservationRequestModel requestModel) async{
    url="";
    dio=Dio();


    var response=
     await networkManager.post(
        Endpoints.PAYMENT_KEY,
         body:requestModel.toJson() ,
         );
    print("ZZZZ"+response["url"]);
    url=  response["url"];
    return response;
  }

  Future cancelReservation(int id) {
    print(id);
    return networkManager.get("${Endpoints.CANCEL_RESERVATION}$id/cancel");
  }

  Future<AllPreviousReservationsResponse?> getAllMyPreviousTransactions() {
    return networkManager
        .get<AllPreviousReservationsResponse>(Endpoints.PREVIOUS_TRANSACTIONS);
  }

  Future<SuccessResponse?> uploadPrescriptionFile(
      File file, int reservationId) async {
    String fileName = file.path.split('/').last;
    final multiPartFile = {
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
      "reservation_id": reservationId
    };
    SuccessResponse? response =
        await networkManager.uploadFile<SuccessResponse>(
            Endpoints.PRESCRIPTION_UPLOAD, multiPartFile);
    if (response?.fileUrl != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<SuccessResponse?> postReservationRate(
      String reservationId, String rate, String review) {
    return networkManager.post<SuccessResponse>(Endpoints.RATE_RESERVATION,
        body: {
          "reservation_id": reservationId,
          "rate": rate,
          "review": review
        });
  }
}
