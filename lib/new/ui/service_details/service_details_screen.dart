// import 'package:auth_manager/config/constant.dart';
// import 'package:auth_manager/new/base/base_state.dart';
// import 'package:auth_manager/new/cache/app_cache.dart';
// import 'package:auth_manager/new/model/reservation_model.dart';
// import 'package:auth_manager/new/model/reservation_request_model.dart';
// import 'package:auth_manager/new/model/upcoming_schedule_model.dart';
// import 'package:auth_manager/new/ui/service_details/service_details_bloc.dart';
// import 'package:auth_manager/widgets/schedule_card.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// class ServiceDetailsScreen extends StatefulWidget {
//   final ReservationModel reservationModel;
//
//   ServiceDetailsScreen({required this.reservationModel});
//
//   @override
//   _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
// }
//
// class _ServiceDetailsScreenState
//     extends BaseState<ServiceDetailsScreen, ServiceDetailsBloc> {
//   @override
//   void initState() {
//     super.initState();
//     bloc.getReservationById(widget.reservationModel.id!);
//   }
//
//   @override
//   Widget buildWidget(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: widget.reservationModel.photo != null
//               ? BoxDecoration(
//                   image: DecorationImage(
//                     // image: AssetImage('assets/images/detail_illustration.png'),
//                     image: NetworkImage(
//                         widget.reservationModel.photo!),
//                     alignment: Alignment.topCenter,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 )
//               : BoxDecoration(color: Theme.of(context).primaryColor),
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 50,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 30,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.3),
//                             border: Border.all(
//                               color: Colors.grey.withOpacity(0.3),
//                             ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SvgPicture.asset(
//                             'assets/icons/back.svg',
//                             height: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.3),
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.3),
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(50))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SvgPicture.asset(
//                           'assets/icons/3dots.svg',
//                           height: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.24,
//               ),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: kBackgroundColor,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(50),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           // Image.asset(
//                           //   _imageUrl,
//                           //   height: 120,
//                           // ),
//                           // SizedBox(
//                           //   width: 20,
//                           // ),
//
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 widget.reservationModel.title!,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: kTitleTextColor,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Price',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: kTitleTextColor,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         widget.reservationModel.price! + " EGP",
//                         style: TextStyle(
//                           height: 1.6,
//                           color: kTitleTextColor.withOpacity(0.7),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Text(
//                         'Description',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: kTitleTextColor,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         widget.reservationModel.description!,
//                         style: TextStyle(
//                           height: 1.6,
//                           color: kTitleTextColor.withOpacity(0.7),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Choose your preferred slot',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: kTitleTextColor,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       getSchedules(),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget getSchedules() {
//     return StreamBuilder<ReservationResponse?>(
//       stream: bloc.reservationByIdController.stream,
//       builder: (context, AsyncSnapshot<ReservationResponse?> snapshot) {
//         if (snapshot.hasData) {
//           List<UpcomingSchedule>? schedules =
//               snapshot.data!.data!.upcomingSchedule;
//           return  Column(
//               children: schedules!.map((schedule) {
//             DateTime? date = DateTime.tryParse(schedule.date!);
//             if (date != null && schedule.availableSlots!.length>0) {
//               String day = formatDate(date, [D]);
//               String dayInMonth = formatDate(date, [d]);
//               String month = formatDate(date, [M]);
//               String? firstSlot = schedule.availableSlots?.first;
//               String? lastSlot = schedule.availableSlots?.last;
//
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () => showBarModalBottomSheet(
//                     context: context,
//                     builder: (context) =>
//                         slotsDialog(schedule.availableSlots!, schedule.date!),
//                   ),
//                   child: ScheduleCard(
//                     day,
//                     '$firstSlot - $lastSlot',
//                     dayInMonth,
//                     month,
//                     kBlueColor,
//                   ),
//                 ),
//               );
//             }
//             return Container();
//           }).toList());
//         }
//         else if (snapshot.hasError) {
//           return Center();
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   Widget slotsDialog(List<dynamic> slots, String selectedDate) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               "Choose Your Time Slot",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//             ),
//           ),
//           for (var slot in slots)
//             Column(
//               children: [
//                 ListTile(
//                   onTap: () async {
//                     final reservationModel = ReservationRequestModel(
//                         date: selectedDate,
//                         serviceId: widget.reservationModel.id!,
//                         time: slot,
//                         userId: AppCache.instance.getUserModel()!.data!.id);
//                     if (await bloc.requestReservation(reservationModel)) {
//                       showSuccessMsg("Slot reserved successfully !");
//                       Navigator.pop(context);
//                     }
//                   },
//                   title: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text('$slot',
//                           style: TextStyle(
//                               fontSize: 15, fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                 ),
//                 Divider()
//               ],
//             ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initBloc() {
//     bloc = ServiceDetailsBloc(this);
//   }
// }
