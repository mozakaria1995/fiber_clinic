import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class CalenderContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final String day;
  final String date;

  const CalenderContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.textColor,
    required this.day,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s10),
      child: Container(
        width: width,
        height: height,
        color: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleWidget(
              title: day,
              fontSize: FontSizeManager.s12,
              color: textColor,
            ),
            TitleWidget(
              title: date,
              fontSize: FontSizeManager.s14,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
