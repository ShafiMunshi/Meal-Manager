import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_manager/constants/app_color.dart';

ThemeData myThemeData() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.appbarColor,
      titleTextStyle: GoogleFonts.poppins(
          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
    ),
    primaryColor: Colors.green,
   // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green),),
    textTheme: GoogleFonts.poppinsTextTheme(),
    // elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: )))
  );
}

final TextTheme textTheme = TextTheme(
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 0.25),
);
