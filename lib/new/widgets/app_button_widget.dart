import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? buttonColor;
  final Color? titleColor;
  final double? width;
  final double? height;
  final String? fontFamily;
  final double? fontSize;
  final bool disabled;

  AppButton(
      {this.title,
      this.onPressed,
      this.buttonColor,
      this.titleColor,
      this.width,
      this.height = 60,
      this.fontFamily = "alhurra",
      this.disabled = false,
      this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: width == null ? size.width : width,
      height: height,
      child:  ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              primary: buttonColor,
              textStyle: TextStyle(fontSize: fontSize)
            )
            ,
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: titleColor, fontFamily: fontFamily, fontSize: fontSize),

            ),
          ),
    );
  }
}
