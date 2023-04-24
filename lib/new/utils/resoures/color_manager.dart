import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#3354F4"); //primary color
  static Color checkColor = HexColor.fromHex("#30B73C"); // check green color
  static Color mainTextColor = HexColor.fromHex("#444444"); // main text color
  static Color lightGreyTextColor = HexColor.fromHex("#3A3A3A");
  static Color secondaryTextColor = HexColor.fromHex("#17181A");
  static Color calenderGrey = HexColor.fromHex("#F2F2F2");
  static Color subTextColor = HexColor.fromHex("#339AF4");
  static Color lightBlueColor = HexColor.fromHex("#2985F1");
  static Color redColor = HexColor.fromHex("#FB0006");
  static Color darkGreyColor = HexColor.fromHex("#606370");
  static Color inActiveBottomNavBarItem = HexColor.fromHex("#9A9A9B");
  static Color scaffoldBackGround = HexColor.fromHex("#FAFAFA");
  static Color paidColor = HexColor.fromHex("#34C04C");
  static Color checkUpColor = HexColor.fromHex("#339AF4");
  static Color separatorColor = HexColor.fromHex("#D8D8D8");
  static Color appointmentTimeColor = HexColor.fromHex("#2E2F35");
  static Color serviceTitleColor = HexColor.fromHex("#2E2F35");
  static Color completeReserved = HexColor.fromHex("#F43340");
  static Color listTileColor = HexColor.fromHex("#606370");



  static Color grey1 = HexColor.fromHex("#808080");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color borderColor = HexColor.fromHex("#77838F");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#000000");
  static Color dividerColor = HexColor.fromHex("#D8D8D8");
  static Color bottomNavBar = HexColor.fromHex("#405ca1");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}