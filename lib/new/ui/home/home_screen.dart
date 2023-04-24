import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/model/reservation_response_model.dart';
import 'package:auth_manager/new/model/upcoming_schedule_model.dart';
import 'package:auth_manager/new/ui/Payment_web_view/payment_screen.dart';
import 'package:auth_manager/new/ui/home/home_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/appointment_card_widget.dart';
import 'package:auth_manager/new/widgets/filter_widget.dart';
import 'package:auth_manager/new/widgets/home_appointment_widget.dart';
import 'package:auth_manager/new/widgets/image_slider_widget.dart';
import 'package:auth_manager/new/widgets/service_card_widget.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  List<ReservationModel>? servicesList;
  ReservationModel? selectedService;
  List<UpcomingSchedule>? schedules;
  List<Reservation>? myReservationsList;
  List<String?>? sliderList;
  ReservationResponse? data;

  @override
  void initState() {
    print(AppCache.keyToken);
    super.initState();

    bloc.getReservations();
    bloc.reservationsController.stream.listen((event) {
      setState(() {
        servicesList = event;
        selectedService = servicesList?[0];
        bloc.getReservationsByServiceId(selectedService?.id! ?? 1);
        bloc.getMyReservationsList();
        sliderList = AppCache.instance
            .getClinicInfo()
            ?.data
            ?.imagesGallery!
            .map((e) => e.imageUrl)
            .toList();
      });
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.all(AppSize.s14),
            children: [
              ImageSlider(
                imgList: (sliderList != null && sliderList!.isNotEmpty)
                    ? sliderList : [],
              ),
              SizedBox(height: AppSize.s20),
              TitleWidget(
                  title:
                      'مرحباً ${AppCache.instance.getUserModel()!.data!.firstName}'),
              SizedBox(height: FontSizeManager.s20),
              StreamBuilder<MyReservationsModel?>(
                stream: bloc.myReservationsController.stream,
                builder:
                    (context, AsyncSnapshot<MyReservationsModel?> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.reservationsList!.length > 0) {
                    myReservationsList = snapshot.data!.reservationsList!;
                    return Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: myReservationsList!.length,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) => AppointmentCard(
                          reservationModel: myReservationsList![index],
                          onCancelClicked: () => openCancelConfirmationDialog(
                              myReservationsList![index].id!),
                        ),
                      ),
                    );
                  } else if (snapshot.data?.reservationsList?.length == 0) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Center();
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: AppSize.s15),
              TitleWidget(title: "اختر الخدمة"),
              Container(
                  height: 220,
                  child: ListView.builder(
                      itemCount: servicesList?.length ?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, i) {
                        return ServiceCard(
                          serviceModel: servicesList![i],
                          isSelected:
                              servicesList![i].id == selectedService!.id,
                          onClicked: () {

                              print("XXXXX");
                              setState(() {
                                selectedService = servicesList![i];
                                bloc.getReservationsByServiceId(
                                    selectedService!.id!);
                              });


                          },
                        );
                      })
                  ),
              SizedBox(height: AppSize.s25),
              TitleWidget(
                  title: selectedService != null
                      ? "مواعيد ال${selectedService!.title}"
                      : ""),
              SizedBox(height: AppSize.s20),
              FutureBuilder<ReservationModel>(
                future: bloc.getReservationsByServiceId(selectedService?.id??1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("حدث خطآ ما"));
                  } else if (snapshot.hasData) {
                    ReservationModel reservationModel = snapshot.data!;
                    List<UpcomingSchedule> schedules = reservationModel.categories![0].upcomingSchedule;
                    return Column(
                      children: schedules.map((schedule) {
                        return schedule.availableSlots.isNotEmpty
                            ? HomeAppointmentCard(
                          upcomingScheduledModel: schedule,
                          photo: reservationModel.photo ?? "",
                          onTab: () => showModalBottomSheet(
                            context: context,
                            isDismissible: true,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            builder: (BuildContext context) {
                              Size size = MediaQuery.of(context).size;
                              return Container(
                                height: size.height * 0.9,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: FilterBottomSheet(
                                    upcoming: schedules,
                                    reservationModel: reservationModel,
                                    selectedDate: schedule.date,
                                    onReserve: (reservationRequestModel) async {
                                      if (reservationRequestModel.paymentType == 1) {
                                        cashReservation(reservationRequestModel, schedule.date);
                                      } else {
                                        creditReservation(reservationRequestModel);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                            : Container();
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          )),
    );
  }

  void cashReservation(ReservationRequestModel reservationRequestModel,
      String scheduleDate) async {
    ReservationResponseModel? reservationResponse =
        await bloc.requestCashOnDeliverReservation(reservationRequestModel);
    if (reservationResponse != null) {
      Navigator.pop(context);
      setState(() {

          schedules!
              .firstWhere((element) => element.date == scheduleDate)
              .availableSlots.removeWhere(
                  (element) => element == reservationRequestModel.time);

      });
      bloc.getMyReservationsList();
      showSuccessMsg("تم حجز الموعد بنجاح");
    }
  }

  void creditReservation(
      ReservationRequestModel reservationRequestModel) async {
    ReservationResponseModel? reservationResponse =
    await bloc.requestCreditReservation(reservationRequestModel,context);
    if(reservationResponse!=null){
      bloc.getMyReservationsList();
      bloc.getReservationsByServiceId(selectedService?.id! ?? 0);
    }



  }

  void openCancelConfirmationDialog(int id) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Text("حذف الموعد المحجوز"),
            content: Text("أنت علي وشك حذف الحجز ، هل تريد المتابعة ؟"),
            actions: [
              AppButton(
                  title: "لا",
                  onPressed: () => Navigator.of(context).pop(),
                  buttonColor: Colors.redAccent),
              SizedBox(height: 10),
              AppButton(
                  title: "نعم",
                  onPressed: () async {
                    if (await bloc.cancelReservation(id)) {
                      Navigator.of(context).pop();
                      setState(() {
                        myReservationsList!
                            .removeWhere((element) => element.id == id);
                      });
                      bloc.getReservationsByServiceId(
                          selectedService?.id! ?? 0);
                      showSuccessMsg("تم إلغاء الحجز بنجاح");
                    }
                  },
                  buttonColor: ColorManager.checkUpColor),
            ],
          ),
        );
        ;
      },
    );
  }

  @override
  void initBloc() {
    bloc = HomeBloc(this);
  }
}
