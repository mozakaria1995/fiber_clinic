import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final Function() onFirstTabTapped;
  final Function() onSecondTabTapped;
  final String firstTabTitle;
  final String secondTabTitle;
  bool firstTabPressed;

   TabBarWidget(
      {Key? key,
      required this.onFirstTabTapped,
      required this.onSecondTabTapped,
      required this.firstTabTitle,
      required this.secondTabTitle,
      required this.firstTabPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.scaffoldBackGround,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: firstTabPressed ? 3.0 : 1.5,
                ),
              ),
            ),
            child: InkWell(
              onTap: onSecondTabTapped,
              child: Center(child: TitleWidget(title: firstTabTitle)),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: ColorManager.scaffoldBackGround,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: !firstTabPressed ? 3.0 : 1.5,
                ),
              ),
            ),
            child: InkWell(
              onTap: onFirstTabTapped,
              child: Center(child: TitleWidget(title:secondTabTitle)),
            ),
          ),
        ),
      ],
    );
  }
}
