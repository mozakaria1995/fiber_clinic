import 'package:auth_manager/new/utils/resoures/style_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //Main App Color
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primary,
      primaryColorDark: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: ColorManager.lightGreyTextColor),
      //ripple color
      splashColor: ColorManager.primary,
      //Card View Theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.lightGreyTextColor,
        elevation: AppSize.s4,
      ),

      //App Bar Theme
      appBarTheme: AppBarTheme(
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primary,
        iconTheme: IconThemeData(color: Colors.black), // 1
        centerTitle: true ,
        titleTextStyle: regularStyle(
          color: ColorManager.white,
          fontSize: FontSizeManager.s16,

        ),
      ),

      //Button Theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primary,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: regularStyle(
            color: ColorManager.white,
            fontSize: FontSizeManager.s20,
          ),
          primary: ColorManager.primary,
          shape: const StadiumBorder(

          ),
        ),
      ),
      // Text theme
      textTheme: TextTheme(
          headline1: semiBoldStyle(
              color: ColorManager.primary, fontSize: FontSizeManager.s16),
          headline2: regularStyle(
              color: ColorManager.white, fontSize: FontSizeManager.s16),
          headline3: boldStyle(
              color: ColorManager.primary, fontSize: FontSizeManager.s14),
          headline4: regularStyle(
              color: ColorManager.lightGreyTextColor, fontSize: FontSizeManager.s16),
          subtitle1: mediumStyle(
              color: ColorManager.mainTextColor,
              fontSize: FontSizeManager.s14),
          subtitle2: mediumStyle(
              color: ColorManager.primary, fontSize: FontSizeManager.s14),
          caption: regularStyle(color: ColorManager.grey1),
          bodyText1: regularStyle(color: ColorManager.mainTextColor)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: regularStyle(color: ColorManager.grey1),

        // label style
        labelStyle: mediumStyle(color: ColorManager.lightGreyTextColor),
        // error style
        errorStyle: regularStyle(color: ColorManager.redColor),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s28))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s28))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.redColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s28))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s28))),
      ));
  //Input Decoration Theme
}
