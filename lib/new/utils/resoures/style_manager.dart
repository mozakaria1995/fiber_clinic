import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular style

TextStyle regularStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontManager.fontFamily,
    color,
    FontWeightManager.regular,
  );
}

// Light style

TextStyle lightStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontManager.fontFamily,
    color,
    FontWeightManager.light,
  );
}

// medium style

TextStyle mediumStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontManager.fontFamily,
    color,
    FontWeightManager.medium,
  );
}
// semibold style

TextStyle semiBoldStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontManager.fontFamily,
    color,
    FontWeightManager.semiBold,
  );
}
// bold style

TextStyle boldStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontManager.fontFamily,
    color,
    FontWeightManager.bold,
  );
}
