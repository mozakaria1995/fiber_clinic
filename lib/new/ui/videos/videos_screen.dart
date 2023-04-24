import 'dart:math';

import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/ui/section_details/section_details_screen.dart';
import 'package:auth_manager/new/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideosScreen extends StatefulWidget {
  final List<Specialty>? specialtiesList;

  VideosScreen({required this.specialtiesList});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {


  final List<IconData> iconsList = [
    FontAwesomeIcons.heart,
    FontAwesomeIcons.bookMedical,
    FontAwesomeIcons.briefcaseMedical,
    FontAwesomeIcons.handHoldingHeart
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        children: [
          SizedBox(height: 10),
          Image.asset(
            "assets/images/circlelogo.png",
            // width: size.width*0.3,
            height: size.height * 0.2,
          ),
          SizedBox(height: 10),
          ...widget.specialtiesList!
              .map((e) => ProfileListTileItem(
              icon: iconsList[Random().nextInt(iconsList.length)],
              title: e.title!,
              onClicked: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SectionDetailsScreen(specialty: e),
                    ));
              }))
              .toList(),
        ],
      ),
    );
  }
}
