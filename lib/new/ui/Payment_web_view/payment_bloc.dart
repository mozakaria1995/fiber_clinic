import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/repositories/payment_repo.dart';

class PaymentBloc extends BaseBloc {
  PaymentBloc(BaseView view) : super(view);
  StreamController<String?> paymentIdController = StreamController();
  PaymentRepo paymentRepo = PaymentRepo();

  void getPaymentEndPoint(ReservationRequestModel requestModel) {
    paymentIdController.add(null);
    paymentRepo.getPaymentUrl(requestModel).then((response) {
      paymentIdController.add(response?.url);
    }, onError: (error) {
      handleError(error);
      if (!paymentIdController.isClosed) {
        paymentIdController.addError(error);
      }
    });
  }

  @override
  void onDispose() {
    paymentIdController.close();
    paymentRepo.dispose();
  }
}