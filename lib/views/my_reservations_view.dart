import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/widgets/reseravtion_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MyReservationsView extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  //LoginController loginController = Get.put(LoginController());

  TextEditingController passwordCtr = TextEditingController();
  TextEditingController newPasswordCtr = TextEditingController();
  TextEditingController newPasswordConfirmationCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            LineAwesomeIcons.angle_left,
                            size: 30,
                          )),
                      SizedBox(height: 30.0),
                      Text(
                        'My Reservations',
                        style: TextStyle(
                            color: kTitleTextColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      ReservationCard(
                          "Session", "2022-05-13", "14:00", "500.00")
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
