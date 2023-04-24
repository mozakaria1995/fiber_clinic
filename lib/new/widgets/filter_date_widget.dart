import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class FilterDateWidget extends StatelessWidget {
  final String? title;
  final String? date;
  final String? day;
  final Function() onTab;
  final bool isSelected;

  const FilterDateWidget({
    Key? key,
    required this.title,
    required this.date,
    required this.day,
    required this.onTab,
    required this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: double.maxFinite,
width: 60,
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWidget(title: title!,color: ColorManager.borderColor),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: isSelected ? ColorManager.checkUpColor : Colors.white,
                  border: Border.all(color: ColorManager.borderColor),
                  shape: BoxShape.circle,
                ),
                width: 35,
                height: 35,
                child: Center(child: TitleWidget(title: date!,color: isSelected ? Colors.white : ColorManager.borderColor,)),
              ),
              const SizedBox(
                height: 10,
              ),
              TitleWidget(title: day!,color: ColorManager.borderColor),
            ],
          ),
        ),
      ),
    );
  }
}
