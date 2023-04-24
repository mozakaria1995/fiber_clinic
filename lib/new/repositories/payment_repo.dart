
import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/payment_url.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class PaymentRepo extends BaseRepo {
  Future<PaymentUrl?> getPaymentUrl(ReservationRequestModel requestModel) {
    return networkManager
        .post<PaymentUrl>(Endpoints.PAYMENT_KEY,body: requestModel.toJson());
  }

}
