import 'package:flutter/material.dart';
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
        ),
        textTheme: TextTheme(
          labelLarge: GoogleFonts.poppins(),
          headlineLarge: GoogleFonts.poppins(),
          headlineMedium: GoogleFonts.poppins(),
          headlineSmall: GoogleFonts.poppins(),
          displayLarge: GoogleFonts.poppins(),
          displayMedium: GoogleFonts.poppins(),
          displaySmall: GoogleFonts.poppins(),
          titleLarge: GoogleFonts.poppins(),
          titleMedium: GoogleFonts.poppins(),
          titleSmall: GoogleFonts.poppins(),
          bodyLarge: GoogleFonts.poppins(),
          bodyMedium: GoogleFonts.poppins(),
          bodySmall: GoogleFonts.poppins(),
        ),
      );

      static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: white),
        ),
        textTheme: TextTheme(
          labelLarge: GoogleFonts.poppins(),
          headlineLarge: GoogleFonts.poppins(),
          headlineMedium: GoogleFonts.poppins(),
          headlineSmall: GoogleFonts.poppins(),
          displayLarge: GoogleFonts.poppins(),
          displayMedium: GoogleFonts.poppins(),
          displaySmall: GoogleFonts.poppins(),
          titleLarge: GoogleFonts.poppins(),
          titleMedium: GoogleFonts.poppins(),
          titleSmall: GoogleFonts.poppins(),
          bodyLarge: GoogleFonts.poppins(),
          bodyMedium: GoogleFonts.poppins(),
          bodySmall: GoogleFonts.poppins(),
        ),

      );    
}
