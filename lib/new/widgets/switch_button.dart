import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatelessWidget {
  final String? title;
  final String? title2;
  final Function()? onPressed;
  final Color? buttonColor;

  final Color? titleColor;
  final double? width;
  final String? fontFamily;
  final double? fontSize;
  final bool disabled;
  final bool select;

  SwitchButton(
      {this.title,
      this.onPressed,
      this.title2,
      this.buttonColor,
      this.titleColor,
      this.width,
      this.fontFamily = "alhurra",
      this.disabled = false,
      this.select = false,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.checkColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            select == true
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TitleWidget(
                          title: title!,
                          color: ColorManager.mainTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 12.0,left: 12),
                    child: TitleWidget(
                      title: title!,
                      color: ColorManager.white,
                      fontSize: 14,
                    ),
                  ),
            SizedBox(
              width: 10,
            ),
            select == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: TitleWidget(
                      title: title2!,
                      color: ColorManager.white,
                      fontSize: 14,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TitleWidget(
                          title: title2!,
                          color: ColorManager.mainTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
