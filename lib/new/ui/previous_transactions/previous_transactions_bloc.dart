import 'dart:async';
import 'dart:io';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/all_prev_reservations_response.dart';
import 'package:auth_manager/new/model/prescription_model.dart';
import 'package:auth_manager/new/model/sucess_response_model.dart';
import 'package:auth_manager/new/repositories/reservation_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rxdart/rxdart.dart';

class PreviousTransactionsBloc extends BaseBloc {
  PreviousTransactionsBloc(BaseView view) : super(view);
  ReservationRepo reservationRepo = ReservationRepo();
  StreamController<List<PreviousReservations>?>
      previousTransactionsListController = BehaviorSubject();

  void getPreviousTransactionsList() {
    previousTransactionsListController.sink.add(null);
    reservationRepo.getAllMyPreviousTransactions().then((response) {

      previousTransactionsListController.sink
          .add(response!.previousReservations);
    }, onError: (error) {
      handleError(error);
      if (!previousTransactionsListController.isClosed) {
        previousTransactionsListController.addError(error);
      }
    });
  }

  @override
  void onDispose() {
    reservationRepo.dispose();
    previousTransactionsListController.close();
  }

  Future<FileItem?> uploadFile(int reservationId) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'png'],
      );
      if (result != null) {
        File file = File(result.files.single.path ?? "");
        view.showProgress();
        SuccessResponse? successResult =
            await reservationRepo.uploadPrescriptionFile(file, reservationId);
        view.hideProgress();
        if (successResult != null) {
          view.showSuccessMsg(successResult.msg);
          return FileItem(
              created: DateTime.now().toIso8601String(),
              pdfUrl: successResult.fileUrl);
        } else {
          view.showErrorMsg("حدث خطأ الرجاء المحاولة لاحقاً");
        }
      } else {
        // User canceled the picker
      }
    } catch (error) {
      handleError(error);
    }
  }

  Future<bool> rateReservation(
      String reservationId, String rate, String review) async {
    try {
      view.showProgress();
      SuccessResponse? successResult = await reservationRepo
          .postReservationRate(reservationId, rate, review);
      view.hideProgress();
      if (successResult != null) {
        view.showSuccessMsg(successResult.msg,duration: 5);
        return true ;
      }

    } catch (error) {
      handleError(error);
    }
    return false ;
  }
}
