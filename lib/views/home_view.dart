import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/controllers/reservation_controller.dart';
import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/models/service_model.dart';
import 'package:auth_manager/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final ReservationController reservationController = Get.find();
  final AuthenticationManager authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       SvgPicture.asset('assets/icons/menu.svg'),
            //       SvgPicture.asset('assets/icons/profile.svg'),
            //       IconButton(
            //         icon: Icon(Icons.logout),
            //         onPressed: () {
            //           loginController.logout();
            //         },
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Hello ${authController.user.value?.firstName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: kTitleTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Find Your Desired Service',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: SearchBar(),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: Text(
            //     'Services',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: kTitleTextColor,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            buildCategoryList(),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   child: Text(
            //     'Top Doctors',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: kTitleTextColor,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // buildDoctorList(),
          ],
        ),
      ),
    );
  }

  buildCategoryList() {
    return Obx(() {
      List<ServiceModel>? _services = reservationController.services.value;
      if (_services == null) {
        return Text("No Services");
      }
      return Flexible(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            childAspectRatio: 1.0,
            mainAxisSpacing: 18),
        itemCount: _services.length,
        // childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        // crossAxisCount: 2,
        // crossAxisSpacing: 18,
        // mainAxisSpacing: 18,
        itemBuilder: (context, index) {
          return CategoryCard(_services[index].title, _services[index].icon, _services[index]);
        },
        // children: reservationController.services?.forEach((element) {
        //   CategoryCard(
        //     'Dental\nxSurgeon',
        //     'assets/icons/dental_surgeon.png',
        //     kBlueColor,
        //   );
      ));
    });
  }
}
