import 'package:auth_manager/new/utils/colors.dart';
import 'package:auth_manager/new/widgets/small_button.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(20),
      width: 300,
      height: 200,
      child: Card(
        margin: EdgeInsets.all(10),

        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/church_logo.png'),
                  Image.asset('assets/images/Users.png'),
                ],
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "قداس يوم الجمعة",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "قداس يوم الجمعة",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "فرد 2",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(width: 20,),
                      SmallButton(
                        title: 'الغاء',
                        onPressed: () {},
                        buttonColor: appSecColor,
                        titleColor: Colors.white,
                        fontSize: 10,
                        width: 50,
                        fontFamily: "Cairo",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
