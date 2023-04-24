
import 'package:auth_manager/new/model/all_prev_reservations_response.dart';
import 'package:auth_manager/new/utils/extensions/arabic_number_extensions.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PreviousTransactionsCard extends StatelessWidget {
  final PreviousReservations transaction ;
  final Function() onPrescriptionTapped;
  final Function() onRateTapped;
  final Function()? onSendFileTapped;
  const PreviousTransactionsCard({required this.transaction,
    required this.onPrescriptionTapped,
    required this.onRateTapped,
    required this.onSendFileTapped
  });

  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(transaction.date!);
    String year = formatDate(date!, [yyyy]);
    String dayInMonth = formatDate(date, [d]);
    String month = formatDate(date, [M]);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s8),
      child: Card(
        elevation: 4,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl:  transaction.service?.photo??"",
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,

                    imageBuilder: (context, imageProvider) => Center(
                      child: CircleAvatar(
                        backgroundImage: imageProvider,
                        minRadius: 80,
                        maxRadius: 100,
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white38,
                        child: Icon(
                          FontAwesomeIcons.filePrescription,
                          color: ColorManager.grey1,
                          size: 40,
                        ),
                        minRadius: 80,
                        maxRadius: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          "تم الإنتهاء من "+ (transaction.service?.title?? ""),
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
                        ),

                        Text(
                            dayInMonth.toArabicDigits() + " " + month.toArabicMonth() + " " + year.toArabicDigits()
                            , maxLines: 1),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    width: 120,
                    height: 40,
                    title: "الروشتات",
                    buttonColor: ColorManager.bottomNavBar,
                    disabled: false,
                    onPressed: onPrescriptionTapped,
                  ),
                  AppButton(
                    width: 120,
                    height: 40,
                    title: "تقييم",
                    buttonColor: Colors.red,
                    disabled: false,
                    onPressed: onRateTapped,
                  )
                ],
              ),
              AppButton(
                width: 140,
                height: 40,
                title: "إرسال ملف للطبيب",
                buttonColor: Colors.grey.shade300,
                titleColor: Colors.black,
                disabled: false,
                onPressed: onSendFileTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
