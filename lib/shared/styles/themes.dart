import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_application/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColoer,
  scaffoldBackgroundColor: HexColor('333740'),
  //primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: defaultColoer),
  // scaffoldBackgroundColor: Colors.white,
  // ignore: prefer_const_constructors
  appBarTheme: AppBarTheme(
      // ignore: deprecated_member_use
      titleSpacing: 20,
      // ignore: deprecated_member_use
      backwardsCompatibility: false,
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333740'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('333740'),
      elevation: 0.0,
      // ignore: prefer_const_constructors
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: Colors.white)),

  // ignore: prefer_const_constructors
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColoer,
    elevation: 30.0,
    backgroundColor: HexColor('333740'),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
  ),
  fontFamily: 'Janna',
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColoer,
  //primarySwatch: Colors.deepOrange,
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: defaultColoer),
  scaffoldBackgroundColor: Colors.white,
  // ignore: prefer_const_constructors
  appBarTheme: AppBarTheme(
      titleSpacing: 20,

      // ignore: deprecated_member_use
      backwardsCompatibility: false,
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      // ignore: prefer_const_constructors
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: Colors.black)),

  // ignore: prefer_const_constructors
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColoer,
    elevation: 30.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
  ),
  fontFamily: 'Janna',
);
