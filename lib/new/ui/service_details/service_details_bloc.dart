import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/repositories/reservation_repo.dart';

class ServiceDetailsBloc extends BaseBloc {
  ServiceDetailsBloc(BaseView view) : super(view);

  ReservationRepo reservationRepo = ReservationRepo();

  StreamController<ReservationsResponse?> reservationsController =
      StreamController();
  StreamController<ReservationResponse?> reservationByIdController =
      StreamController();

  void getReservationsList() {
    reservationsController.add(null);
    reservationRepo.getReservationsList().then((response) {
      reservationsController.add(response);
    }, onError: (error) {
      handleError(error);
      if (!reservationsController.isClosed) {
        reservationsController.addError(error);
      }
    });
  }

  void getReservationById(int reservationId) {
    reservationByIdController.add(null);
    reservationRepo.getReservationById(reservationId).then((response) {
      reservationByIdController.add(response);
    }, onError: (error) {
      handleError(error);
      if (!reservationByIdController.isClosed) {
        reservationByIdController.addError(error);
      }
    });
  }

  Future<bool> requestReservation(ReservationRequestModel requestModel) async {
    try {

      view.showProgress();
      final response = await reservationRepo.reserveCashOnDeliverReservation(requestModel);
      view.hideProgress();
      if (response != null) {
        return true;
      }
    } catch (error) {
      print("Ziko"+error.toString());
      handleError(error);
    }
    return false;
  }

  @override
  void onDispose() {
    reservationRepo.dispose();
    reservationsController.close();
    reservationByIdController.close() ;
  }
}
