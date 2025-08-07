import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

//App Colors
Color primaryColor = const Color(0xFF000000);
Color secondaryColor = const Color(0xFF000000);
Color scaffoldBackgroundColor = const Color(0xFFF5F5F5);

//Common Colors
Color white = Colors.white;
Color black = Colors.black;
Color grey = Colors.grey;
Color red = Colors.red;
Color green = Colors.green;
Color blue = Colors.blue;
Color yellow = Colors.yellow;
Color orange = Colors.orange;

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: black),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: textTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: textTheme,
      );
}

TextTheme textTheme = TextTheme(
  labelLarge: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  headlineLarge: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),
  displayLarge: GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  ),
);
