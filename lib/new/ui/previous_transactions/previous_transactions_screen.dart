import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/all_prev_reservations_response.dart';
import 'package:auth_manager/new/model/prescription_model.dart';
import 'package:auth_manager/new/ui/previous_transactions/prescription_bottom_sheet.dart';
import 'package:auth_manager/new/ui/previous_transactions/previous_transactions_bloc.dart';
import 'package:auth_manager/new/ui/previous_transactions/rating_bottom_sheet.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/prev_transaction_card.dart';
import 'package:flutter/material.dart';

class PreviousTransactionsScreen extends StatefulWidget {
  const PreviousTransactionsScreen({Key? key}) : super(key: key);

  @override
  State<PreviousTransactionsScreen> createState() =>
      _PreviousTransactionsScreenState();
}

class _PreviousTransactionsScreenState
    extends BaseState<PreviousTransactionsScreen, PreviousTransactionsBloc> {
  late List<PreviousReservations>? transactionsList;

  @override
  void initBloc() {
    bloc = PreviousTransactionsBloc(this);
  }

  @override
  void initState() {
    super.initState();
    bloc.getPreviousTransactionsList();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.onDispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder<List<PreviousReservations>?>(
          stream: bloc.previousTransactionsListController.stream,
          builder:
              (context, AsyncSnapshot<List<PreviousReservations>?> snapshot) {
            print("here" + snapshot.hasData.toString());
            if (snapshot.hasData) {
              transactionsList = snapshot.data!;

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s8),
                children: [
                  SizedBox(height: AppSize.s10),
                  ...transactionsList!
                      .map(
                        (transaction) => PreviousTransactionsCard(
                      transaction: transaction,
                      onPrescriptionTapped: () =>
                          openPrescriptionsBottomSheet(
                            transaction.id ?? -1,
                            false,
                          ),
                      onRateTapped: () =>
                          openRateBottomSheet(transaction.id ?? -1),
                      onSendFileTapped: () => openPrescriptionsBottomSheet(
                        transaction.id ?? -1,
                        true,
                      ),
                    ),
                  )
                      .toList(),
                  SizedBox(height: AppSize.s30),
                ],
              );
            } else if (snapshot.hasError) {
              return Center();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void openPrescriptionsBottomSheet(int transactionId, bool fromSendFile) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return Container(
            height: size.height * 0.9,
            decoration: BoxDecoration(
              color: ColorManager.scaffoldBackGround,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PrescriptionBottomSheet(
                prescriptionList: fromSendFile
                    ? (transactionsList
                    ?.firstWhere(
                        (element) => element.id == transactionId)
                    .files ??
                    [])
                    : (transactionsList
                    ?.firstWhere(
                        (element) => element.id == transactionId)
                    .prescriptions ??
                    []),
                onUploadFileTapped: () =>
                fromSendFile ? uploadFile(transactionId) : null,
                comesFromSendFile: fromSendFile,
              ),
            ),
          );
        });
  }

  void uploadFile(int transactionId) async {
    int id = transactionsList
        ?.firstWhere((element) => element.id == transactionId)
        .id ??
        -1;
    if (id != -1) {
      FileItem? newPrescription = await bloc.uploadFile(id);
      if (newPrescription != null) {
        transactionsList
            ?.firstWhere((element) => element.id == transactionId)
            .files
            ?.add(newPrescription);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }
  }

  void openRateBottomSheet(int transactionId) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;
          return Container(
            height: size.height * 0.9,
            decoration: BoxDecoration(
              color: ColorManager.scaffoldBackGround,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: RatingBottomSheet(
                onSubmitCallback: (String rate, String review) async {
                  if (await bloc.rateReservation(
                      "$transactionId", rate, review)) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          );
        });
  }
}
