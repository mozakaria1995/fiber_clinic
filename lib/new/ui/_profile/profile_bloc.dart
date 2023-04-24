import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/repositories/reservation_repo.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BaseBloc {
  ProfileBloc(BaseView view) : super(view);
  ReservationRepo reservationRepo = ReservationRepo();

  StreamController<MyReservationsModel?> myReservationsController =
      BehaviorSubject();
  StreamController<ReservationResponse?> appointmentsByServiceIdController =
  BehaviorSubject();

  @override
  void onDispose() {
    myReservationsController.close();
    appointmentsByServiceIdController.close();
    reservationRepo.dispose();

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
  void getReservationsByServiceId(int serviceId) {
    appointmentsByServiceIdController.add(null);
    reservationRepo.getReservationById(serviceId).then((response) {
      appointmentsByServiceIdController.add(response);
    }, onError: (error) {
      handleError(error);
      if (!appointmentsByServiceIdController.isClosed) {
        appointmentsByServiceIdController.addError(error);
      }
    });
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
}
