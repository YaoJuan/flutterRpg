import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color.fromRGBO(162, 29, 19, 1);
  static Color primaryAccent = const Color.fromRGBO(120, 14, 14, 1);
  static Color secondaryColor = const Color.fromRGBO(45, 45, 45, 1);
  static Color secondaryAccent = const Color.fromRGBO(35, 35, 35, 1);
  static Color titleColor = const Color.fromRGBO(200, 200, 200, 1);
  static Color textColor = const Color.fromRGBO(150, 150, 150, 1);
  static Color successColor = const Color.fromRGBO(9, 149, 110, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

final ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.textColor,
      surfaceTintColor: Colors.transparent),
  scaffoldBackgroundColor: AppColors.secondaryAccent,
  textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 16,
        letterSpacing: 1,
      ),
      headlineMedium: TextStyle(
          color: AppColors.titleColor,
          fontSize: 16,
          letterSpacing: 1,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: AppColors.titleColor,
          fontSize: 18,
          letterSpacing: 2,
          fontWeight: FontWeight.bold)),
  // cardTheme
  cardTheme: CardTheme(
      color: AppColors.secondaryColor,
      elevation: 2,
      shadowColor: AppColors.secondaryAccent,
      margin: const EdgeInsets.all(5)),
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     side: BorderSide(color: AppColors.primaryColor, width: 2))),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.secondaryColor.withOpacity(0.5),
    border: InputBorder.none, 
    labelStyle: TextStyle(color: AppColors.textColor),
    prefixIconColor: AppColors.textColor,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.secondaryAccent,
    surfaceTintColor: AppColors.secondaryAccent,
  ),
);
