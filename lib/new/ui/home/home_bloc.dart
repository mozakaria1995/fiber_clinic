import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/model/reservation_response_model.dart';
import 'package:auth_manager/new/network/network_manager.dart';
import 'package:auth_manager/new/repositories/reservation_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../cache/app_cache.dart';
import '../Payment_web_view/payment_screen.dart';
ReservationModel? reservationModel;

class HomeBloc extends BaseBloc {
  HomeBloc(BaseView view) : super(view);
  bool isLoading=true;

  ReservationRepo reservationRepo = ReservationRepo();
  StreamController<List<ReservationModel>?> reservationsController =
  BehaviorSubject();
  // StreamController<ReservationResponse?> appointmentsByServiceIdController =
  //     BehaviorSubject();

  StreamController<MyReservationsModel?> myReservationsController =
  BehaviorSubject();

  void getReservations() {
    reservationsController.add(null);
    reservationRepo.getReservationsList().then((response) {
      reservationsController.add(response!.data);
    }, onError: (error) {
      handleError(error);
      if (!reservationsController.isClosed) {
        reservationsController.addError(error);
      }
    });
  }

  void getMyReservationsList() {
    myReservationsController.add(null);
    reservationRepo.getMyReservations().then((response) {
      myReservationsController.add(response!);
    }, onError: (error) {
      handleError(error);
      if (!myReservationsController.isClosed) {
        myReservationsController.addError(error);
      }
    });
  }

  Future<ReservationModel> getReservationsByServiceId(int serviceId) async {
    ReservationModel reservationModel;
    bool isLoading = true;
    var response;

    try {
      response = await reservationRepo.getReservationById(serviceId);
      reservationModel = ReservationModel.fromJson(response["data"]);
      isLoading = false;
    } catch (error) {
      if (error is DioError) {
        isLoading = false;
      }
      handleError(error);
    }

    return response;
  }


  // Future getReservationsByServiceId(int serviceId) async {
  //     reservationModel = null;
  //     isLoading = true;
  //
  //     return reservationRepo.getReservationById(serviceId)
  //         .then((response) {
  //       reservationModel = ReservationModel.fromJson(response["data"]);
  //       isLoading = false;
  //     })
  //         .catchError((error) {
  //       if (error is DioError) {
  //         isLoading = false;
  //       }
  //       handleError(error);
  //     });
  //   }


  Future<ReservationResponseModel?> requestCashOnDeliverReservation(
      ReservationRequestModel requestModel) async {
    try {
      view.showProgress();
      final response =
      await reservationRepo.reserveCashOnDeliverReservation(requestModel);
      view.hideProgress();
      if (response != null) {
        return response;
      }
    } catch (error) {
      print(error);
      handleError(error);
    }
    return null;
  }


  Future<ReservationResponseModel?> requestCreditReservation(
      ReservationRequestModel requestModel,context) async {
    try {
      view.showProgress();
      final response =
      await reservationRepo.reserveCreditReservation(requestModel);
      view.hideProgress();
      if (response != null) {
        print(url);
        Navigator.pop(context);
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentScreen(requestModel: requestModel);
        }));
      }
    } catch (error) {
      print(error);
      handleError(error);
    }
    return null;
  }

  Future<bool> cancelReservation(int reservationId) async {
    try {
      view.showProgress();
      final response = await reservationRepo.cancelReservation(reservationId);

      view.hideProgress();
      if (response != null) {
        return true;
      }
    } catch (error) {
      print(error);
      handleError(error);
    }
    return false;
  }

  @override
  void onDispose() {
    reservationRepo.dispose();
    reservationsController.close();
    myReservationsController.close() ;
    // appointmentsByServiceIdController.close();
  }
}
