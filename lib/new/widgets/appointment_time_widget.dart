import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class AppointmentTimeWidget extends StatelessWidget {
  final String time;
  final double width;
  final double height;
  final Color textColor;
  final Color borderColor;
  final bool isSelected;
  final Function() onTab;

  const AppointmentTimeWidget({
    Key? key,
    required this.time,
    required this.textColor,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.isSelected,
    required this.onTab
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(

            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? ColorManager.checkUpColor : Colors.white,
          ),
          child: Center(
            child: TitleWidget(title: time, color: isSelected ? Colors.white :textColor),
          ),
        ),
      ),
    );
  }
}
