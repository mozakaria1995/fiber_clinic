import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/utils/extensions/arabic_number_extensions.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'app_button_widget.dart';

class AppointmentCard extends StatelessWidget {
  final Reservation reservationModel;
  final Function onCancelClicked;
  final bool isProfile;

  const AppointmentCard(
      {required this.reservationModel,
      required this.onCancelClicked,
      this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(reservationModel.date!);
    String year = formatDate(date!, [yyyy]);
    String weekDay = formatDate(date, [DD]);
    String dayInMonth = formatDate(date, [d]);
    String month = formatDate(date, [M]);
    return Padding(
      padding: const EdgeInsets.only(right: AppSize.s16),
      child: Container(
        width: 277,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWidget(
                    title: reservationModel.service!.title ?? "",
                    fontSize: AppSize.s12,
                    color: ColorManager.checkUpColor,
                  ),
                  TitleWidget(
                    title: getReservationStatus(),
                    fontSize: AppSize.s14,
                    color: ColorManager.paidColor,
                  )
                ],
              ),
              SizedBox(height: AppSize.s16),
              Container(
                color: ColorManager.separatorColor,
                height: 1,
                width: 277,
              ),
              SizedBox(height: AppSize.s16),
              Row(

                children: [
                  Container(

                    color: ColorManager.paidColor,
                    height: 55,
                    width: 4,
                  ),
                  SizedBox(width: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        !isProfile
                            ?( dayInMonth.toArabicDigits() + " " + month.toArabicMonth() + " " + year.toArabicDigits() )
                            : (reservationModel.dateInDaysStatus == true
                                ? "متبقي ${reservationModel.dateInDays} يوم  "
                                : reservationModel.dateInHoursStatus == true ?"متبقي ${reservationModel.dateInHours} ساعة  ":"متبقي ${reservationModel.dateInMints} دقيقة  "),
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: FontManager.fontFamily,
                            fontWeight: FontWeightManager.regular,
                            fontSize: FontSizeManager.s12),
                      ),
                      Text(
                        "${reservationModel.time ?? ""} - ${reservationModel.toTime ?? ""}",
                        style: TextStyle(
                            color: ColorManager.appointmentTimeColor,
                            fontFamily: FontManager.fontFamily,
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSizeManager.s14),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: AppSize.s16),
              Expanded(
                child: Container(width: 100,
                  child:

                  AppButton(

                      buttonColor: Colors.red,
                      onPressed: () => onCancelClicked(),
                      title: "إلغاء الحجز"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getReservationStatus() {
    switch (reservationModel.paymentType) {
      case null:
        return "غير مدفوع";
      case "2":
        return "مدفوع";
      case "1":
        return "دفع عند الوصول";
    }
    return "";
  }
}
