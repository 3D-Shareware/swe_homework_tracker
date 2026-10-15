import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class Themes {
  static final meanGreenTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 223, 225, 223),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Color.fromARGB(255, 11, 110, 24),
    ),
    fontFamily: GoogleFonts.bitter().fontFamily,
  );
}
