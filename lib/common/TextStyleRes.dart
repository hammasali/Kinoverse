import 'package:flutter/material.dart';

import '../app.dart';

class TextStyleRes {
  static textStyleFont1(
      {text, double fontSize, textAlign, textColor, fontWeight}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: App.font1,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  static textUbuntuStyleFont2({text, double fontSize, fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: App.font2,
          color: txtColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  static textUbuntuStyleFont3({text, double fontSize, fontWeight, txtColor}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: App.font2,
          color: txtColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
