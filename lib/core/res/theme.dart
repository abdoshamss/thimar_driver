import 'package:flutter/material.dart';
import 'package:thimar_driver/core/res/color.dart';

final ThemeData theme=ThemeData(
  androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: getMaterialColor(primaryColor.value),
  unselectedWidgetColor: const Color(0xffF3F3F3),
  hintColor: const Color(0xff808080),
  fontFamily: "Tajawal",
  dividerColor: const Color(0xffF6F6F6),
  appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: primaryColor,
      )),
  dividerTheme: const DividerThemeData(
    color: Color(0xffF3F3F3),
    thickness: 2
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Color(0xffF3F3F3),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Color(0xffF3F3F3),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(38),
          topRight: Radius.circular(38))),)
);