import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? buttonColor;
  final Color? titleColor;
  final double? width;
  final String? fontFamily;
  final double? fontSize;
  final bool disabled;

  SmallButton(
      {this.title,
        this.onPressed,
        this.buttonColor,
        this.titleColor,
        this.width,
        this.fontFamily = "alhurra",
        this.disabled = false,
        this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return ButtonTheme(
        height: 20,
        minWidth: 50,
        buttonColor: buttonColor,
        // ignore: deprecated_member_use
        child: ElevatedButton(
          style:ButtonStyle( shape:MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),) ) ,
     onPressed: disabled ? null : onPressed,
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: titleColor,
                fontSize: this.fontSize,
                fontFamily: this.fontFamily),
          ),
        ));
  }
}
