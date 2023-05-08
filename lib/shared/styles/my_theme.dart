import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c8_monday/shared/styles/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightGreenColor,
      primaryColor: primaryColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade400,
      ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.roboto(
            fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
        bodyMedium: GoogleFonts.elMessiri(
            fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white, size: 35),
        backgroundColor: primaryColor,
      ));
  static ThemeData darkTheme = ThemeData();
}
