
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:flutter/material.dart';

class AppointmentSlot extends   StatelessWidget {
  final String slot ;
  final Color color;
  const AppointmentSlot({required this.slot,required this.color}) ;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: AppSize.s8),
      child: Container(
        width: AppSize.s80,
        height: AppSize.s25,

        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius:
            BorderRadius.all(Radius.circular(AppSize.s8))),
        child: Center(
          child: Text(slot,
            textAlign: TextAlign.center,
            style: TextStyle(

                fontSize: AppSize.s12,
                color: Colors.white,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold),
          ),
        ),
      ),
    );
  }
}
