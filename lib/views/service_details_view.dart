import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/controllers/reservation_controller.dart';
import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/models/schedule_reservation_model.dart';
import 'package:auth_manager/models/service_model.dart';
import 'package:auth_manager/widgets/schedule_card.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ServiceDetailsView extends StatefulWidget {
  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  final ServiceModel _service = Get.arguments['service'];

  final ReservationController _reservationController = Get.find();

  final AuthenticationManager _authManager = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_service != null) {
      _reservationController.getSchedule(_service.id!);

      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: _service.photo != null
                ? BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage('assets/images/detail_illustration.png'),
                      image: NetworkImage(_service.photo!),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/back.svg',
                              height: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/3dots.svg',
                            height: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // Image.asset(
                            //   _imageUrl,
                            //   height: 120,
                            // ),
                            // SizedBox(
                            //   width: 20,
                            // ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _service.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: kTitleTextColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _service.price! + " EGP",
                          style: TextStyle(
                            height: 1.6,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _service.description!,
                          style: TextStyle(
                            height: 1.6,
                            color: kTitleTextColor.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Choose your preferred slot',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kTitleTextColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        getSchedules(context),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget slotsDialog(List<dynamic> slots, String selectedDate) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Choose Your Time Slot",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          for (var slot in slots)
            Column(
              children: [
                ListTile(
                  onTap: () async {
                    EasyLoading.show(status: "Making Reservation");
                    Get.back();

                    if (await _reservationController.reserveService(
                        _service.id!,
                        _authManager.user.value!.id!,
                        selectedDate,
                        slot)) {
                      EasyLoading.showSuccess("Reservation Successful");
                    } else {
                      EasyLoading.showError(
                          "Error in making reservation, try again");
                    }
                    setState(() {});
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('$slot',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Divider()
              ],
            ),
        ],
      ),
    );
  }

  Widget getSchedules(BuildContext context) {
    return FutureBuilder(
      future: _reservationController.getSchedule(_service.id!),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              List<ScheduleReservationModel>? schedules = snapshot.data;
              return Column(
                  children: schedules!.map((schedule) {
                DateTime? date = DateTime.tryParse(schedule.date!);
                if (date != null) {
                  String day = formatDate(date, [D]);
                  String dayInMonth = formatDate(date, [d]);
                  String month = formatDate(date, [M]);
                  String? firstSlot = schedule.slots?.first;
                  String? lastSlot = schedule.slots?.last;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            slotsDialog(schedule.slots!, schedule.date!),
                      ),
                      child: ScheduleCard(
                        day,
                        '$firstSlot - $lastSlot',
                        dayInMonth,
                        month,
                        kBlueColor,
                      ),
                    ),
                  );
                }
                return Container();
              }).toList());
            }
          } else {
            return Text("No Upcoming Schedules");
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }

        return Container();
      },
    );
  }
}
