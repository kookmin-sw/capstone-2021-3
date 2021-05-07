import 'package:flutter/material.dart';
import 'package:inobus/app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  // fontFamily: 'Georgia',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headline2: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
    ),
  ),
);
