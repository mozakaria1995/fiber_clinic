import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/model/upcoming_schedule_model.dart';
import 'package:auth_manager/new/utils/extensions/arabic_number_extensions.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/text_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/switch_button.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'app_button_widget.dart';
import 'appointment_time_widget.dart';
import 'filter_date_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final ReservationModel reservationModel;
  final String selectedDate;
  final List <UpcomingSchedule> upcoming;
  final Function(ReservationRequestModel requestModel) onReserve;

  const FilterBottomSheet(
      {required this.reservationModel,
      required this.selectedDate,
      required this.upcoming,
      required this.onReserve});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // bool check = true;
  int radioSelection = 1;

  late Categories _selectedCategory = widget.reservationModel.categories![0];


  late UpcomingSchedule selectedDateSchedule = widget
      .reservationModel.categories![0].upcomingSchedule
      .firstWhere((element) => element.date == widget.selectedDate);
  late String selectedSlot = selectedDateSchedule.availableSlots[0].time;

  late List selectedSlotID=selectedDateSchedule.availableSlots[0].reservationServiceDaySlotsIds;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                  child: Text(widget.reservationModel.title!,style: TextStyle(fontSize: 16,color: Colors.red,fontWeight: FontWeight.bold),)),
            ),
            TitleWidget(
              title: AppStrings.title,
              fontSize: 24,
              color: ColorManager.primary,
            ),
            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Visibility(
            //         visible: widget.reservationModel.hasConsultation == "1",
            //         child: SwitchButton(
            //           title: "كشف",
            //           width: 150,
            //           title2: "إستشارة",
            //           select: check,
            //           onPressed: () {
            //             setState(() {
            //               check = !check;
            //             });
            //           },
            //         ),
            //       ),
            //       TitleWidget(
            //         title: widget.reservationModel.hasConsultation == "1"
            //             ? AppStrings.appointment
            //             : AppStrings.appointmentWithoutConsultation,
            //         fontSize: 14,
            //         color: ColorManager.mainTextColor,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 10,),

            DropdownButtonFormField<Categories>(
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
              isExpanded: true,
               dropdownColor: Colors.blue,
              decoration: InputDecoration(
                fillColor: Colors.blue,


                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
              ),
              style:TextStyle(
                fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,) ,
              value: _selectedCategory,
              items: widget.reservationModel.categories!.map((Categories category) {
                return DropdownMenuItem<Categories>(
                  value: category,
                  child: Center(child: Text(category.name,textAlign: TextAlign.center)),
                );
              }).toList(),
              onChanged: (Categories? newValue) {

                setState(() {
                  _selectedCategory = newValue!;
                    selectedDateSchedule = _selectedCategory.upcomingSchedule.firstWhere((element) => element.date == widget.selectedDate);
                   selectedSlot = selectedDateSchedule.availableSlots[0].time;
                  print(selectedSlot);

                });
              },
            ),


            // const SizedBox(
            //   height: 25,
            // ),
            // Visibility(
            //   visible: widget.reservationModel.hasConsultation == "1",
            //   child: TitleWidget(
            //     title: "مواعيد ال${check ? "كشف" : "إستشارة"} المتاحة ",
            //     fontSize: 14,
            //     color: ColorManager.mainTextColor,
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2 / 1),
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: selectedDateSchedule.availableSlots.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  return AppointmentTimeWidget(
                    time: selectedDateSchedule.availableSlots[i].time,
                    // containerColor: ColorManager.white,
                    textColor: ColorManager.borderColor,
                    borderColor: ColorManager.borderColor,
                    height: 45,
                    width: 120,
                    onTab: () {
                      setState(() {
                        selectedSlot =
                            selectedDateSchedule.availableSlots[i].time;

                        selectedSlotID= selectedDateSchedule.availableSlots[i].reservationServiceDaySlotsIds;
                        print(selectedSlotID);

                      });
                    },
                    isSelected: selectedSlot ==
                        selectedDateSchedule.availableSlots[i].time,
                  );
                }),

            const SizedBox(height: 25),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppointmentTimeWidget(
                    time: formatDate(
                            DateTime.tryParse(selectedDateSchedule.date)!,
                            [d]).toArabicDigits() +
                        " " +
                        formatDate(
                            DateTime.tryParse(selectedDateSchedule.date)!,
                            [M]).toArabicMonth(),
                    isSelected: true,
                    textColor: ColorManager.white,
                    borderColor: ColorManager.primary,
                    height: 35,
                    width: 100,
                    onTab: () {},
                  ),
                  TitleWidget(
                    title: AppStrings.appointmentDate,
                    fontSize: 14,
                    color: ColorManager.mainTextColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return FilterDateWidget(
                    day: formatDate(

                        DateTime.tryParse(widget
                            .reservationModel.categories![0].upcomingSchedule[i].date)!,
                        [DD]).toArabicWeekDay(),
                    date: formatDate(
                        DateTime.tryParse(widget
                            .reservationModel.categories![0].upcomingSchedule[i].date)!,
                        [d]).toArabicDigits(),
                    title: formatDate(
                        DateTime.tryParse(widget
                            .reservationModel.categories![0].upcomingSchedule[i].date)!,
                        [M]).toArabicMonth(),
                    onTab: () {
                      setState(() {
                        selectedDateSchedule =
                            widget.reservationModel.categories![0].upcomingSchedule[i];
                      });
                    },
                    isSelected: selectedDateSchedule ==
                        widget.reservationModel.categories![0].upcomingSchedule[i],
                  );
                },
                itemCount: widget.reservationModel.categories![0].upcomingSchedule.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Text(
                            "عند الوصول",
                            style: TextStyle(
                                fontSize: AppSize.s16,
                                color: Colors.black,
                                fontFamily: FontManager.fontFamily,
                                fontWeight: FontWeightManager.bold),
                          ),
                          Radio(
                            value: 1,
                            groupValue: radioSelection,
                            activeColor: ColorManager.checkUpColor,
                            onChanged: (value) {
                              setState(() {
                                radioSelection = 1;
                                print(radioSelection);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "البطاقة الإئتمانية (الكريديت)",
                          style: TextStyle(
                              fontSize: AppSize.s16,
                              color: Colors.black,
                              fontFamily: FontManager.fontFamily,
                              fontWeight: FontWeightManager.bold),
                        ),
                        Radio(
                          value: 2,
                          groupValue: radioSelection,
                          activeColor: ColorManager.checkUpColor,
                          onChanged: (value) {
                            setState(() {
                              radioSelection = 2;
                              print(radioSelection);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                TitleWidget(
                  title: "أفضل الدفع :",
                ),
              ],
            ),

            Center(
              child: AppButton(
                onPressed: () async {
                  final reservationModel = ReservationRequestModel(
                      date: selectedDateSchedule.date,
                      serviceId: widget.reservationModel.id!,
                      time: selectedSlot,
                      paymentType: radioSelection,
                      // reservationType: check ? 1 : 2 ,
                       categoryId: _selectedCategory.id,
                       slotID: selectedSlotID,
                      userId: AppCache.instance.getUserModel()!.data!.id);

                  await widget.onReserve(reservationModel);
                },
                title: AppStrings.confirm,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
