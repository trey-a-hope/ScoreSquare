import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  //Colors
  static const colorBlack = Colors.black;
  static const colorGrey = Color.fromRGBO(141, 141, 141, 1.0);
  static const colorWhite = Colors.white;
  static const colorDarkBlue = Color.fromRGBO(20, 25, 45, 1.0);

//Fonts
  static const String fontFamily = 'Montserrat';

  static const TextTheme textTheme = TextTheme(
    headline1: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 26,
      fontFamily: fontFamily,
    ),
    headline2: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      fontFamily: fontFamily,
    ),
    headline3: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 20,
      fontFamily: fontFamily,
    ),
    headline4: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
    headline5: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 14,
      fontFamily: fontFamily,
    ),
    headline6: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w700,
      fontSize: 12,
      fontFamily: fontFamily,
    ),
    bodyText1: TextStyle(
      color: colorWhite,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.5,
      fontFamily: fontFamily,
    ),
    bodyText2: TextStyle(
      color: colorGrey,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.5,
      fontFamily: fontFamily,
    ),
    subtitle1: TextStyle(
      color: colorBlack,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: fontFamily,
    ),
    subtitle2: TextStyle(
      color: colorGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: fontFamily,
    ),
  );
}
