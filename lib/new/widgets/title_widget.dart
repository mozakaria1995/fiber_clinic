import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  TitleWidget({Key? key, required this.title, this.fontSize, this.color,this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      style: fontSize == null&&color==null
          ? Theme.of(context).textTheme.headline1
          : Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: fontSize, color: color == null ? null : color),
    );
  }
}
