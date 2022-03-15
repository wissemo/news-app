import 'package:flutter/material.dart';

import 'colors.dart';

const openSans = "OpenSans";

final ThemeData appTheme = ThemeData(
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[700],
  ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  secondaryHeaderColor: secondaryColor,
  errorColor: errorColor,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 2,
    titleTextStyle: TextStyle(
        fontSize: 15.0,
        color: Colors.white,
        fontFamily: openSans,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: greyColor),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
      borderSide: BorderSide(
        color: greyColor,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
      borderSide: BorderSide(color: errorColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
      borderSide: BorderSide(color: secondaryColor),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    backgroundColor: successColor,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 15.0,
      color: blackColor,
      fontFamily: openSans,
      fontWeight: FontWeight.w600,
    ),
    headline2: TextStyle(
        fontFamily: openSans,
        color: darkGreyColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w600),
    bodyText1: TextStyle(
      fontSize: 12.0,
      color: greyColor,
      fontFamily: openSans,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontSize: 10.0,
      color: lightBlackColor,
      fontFamily: openSans,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontSize: 8.0,
      color: lightBlackColor,
      fontFamily: openSans,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      textStyle: const TextStyle(
          fontFamily: openSans,
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600),
      onPrimary: secondaryColor,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
      space: 10, thickness: 1, color: darkGreyColor, indent: 10, endIndent: 10),
);
