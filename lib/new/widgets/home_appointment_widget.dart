
import 'package:auth_manager/new/model/upcoming_schedule_model.dart';
import 'package:auth_manager/new/utils/extensions/arabic_number_extensions.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'appointment_slot_card_widget.dart';

class HomeAppointmentCard extends StatelessWidget {
  final UpcomingSchedule upcomingScheduledModel;
  final String photo;
  final Function() onTab;

  const HomeAppointmentCard(
      {required this.photo, required this.upcomingScheduledModel, required this.onTab});

  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(upcomingScheduledModel.date);
    String year = formatDate(date!, [yyyy]);
    String weekDay = formatDate(date, [DD]);
    String dayInMonth = formatDate(date, [d]);
    String month = formatDate(date, [M]);
    String firstSlot = upcomingScheduledModel.availableSlots.first.time;
    String? lastSlot = upcomingScheduledModel.availableSlots.last.time;
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSize.s16),
        child: Container(

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          child: Padding(
            padding: EdgeInsets.all(AppSize.s14),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 77.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black26, BlendMode.hardLight),
                            image: CachedNetworkImageProvider(photo)),
                      ),
                    ),
                    Text(
                      weekDay.toArabicWeekDay(),
                      style: TextStyle(
                          fontSize: AppSize.s13,
                          color: Colors.white,
                          fontFamily: FontManager.fontFamily,
                          fontWeight: FontWeightManager.bold),
                    )
                  ],
                ),
                SizedBox(width: AppSize.s20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekDay.toArabicWeekDay(),
                      style: TextStyle(
                          fontSize: AppSize.s14,
                          color: ColorManager.appointmentTimeColor,
                          fontFamily: FontManager.fontFamily,
                          fontWeight: FontWeightManager.medium),
                    ),
                    SizedBox(height: AppSize.s6),
                    Text(
                      dayInMonth.toArabicDigits() + " " + month.toArabicMonth() + " " + year.toArabicDigits(),
                      style: TextStyle(
                          fontSize: AppSize.s12,
                          color: ColorManager.inActiveBottomNavBarItem,
                          fontFamily: FontManager.fontFamily,
                          fontWeight: FontWeightManager.regular),
                    ),
                    SizedBox(height: AppSize.s10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppointmentSlot(
                          slot: firstSlot,
                          color: ColorManager.paidColor,
                        ),
                        lastSlot != null
                            ? AppointmentSlot(
                                slot: lastSlot,
                                color: ColorManager.checkUpColor,
                              )
                            : Container()
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
