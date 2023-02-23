import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF6B38FB);
final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.merriweather(
    textStyle: const TextStyle(
        fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  ),
  headline2: GoogleFonts.merriweather(
      textStyle: const TextStyle(
          fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5)),
  headline3: GoogleFonts.merriweather(
    textStyle: const TextStyle(fontSize: 46, fontWeight: FontWeight.w400),
  ),
  headline4: GoogleFonts.merriweather(
    textStyle: const TextStyle(
        fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  ),
  headline5: GoogleFonts.merriweather(
    textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
  ),
  headline6: GoogleFonts.merriweather(
    textStyle: const TextStyle(
        fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  ),
  subtitle1: GoogleFonts.merriweather(
    textStyle: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  ),
  subtitle2: GoogleFonts.merriweather(
    textStyle: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  ),
  bodyText1: GoogleFonts.libreFranklin(
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  ),
  bodyText2: GoogleFonts.libreFranklin(
    textStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  ),
  button: GoogleFonts.libreFranklin(
    textStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  ),
  caption: GoogleFonts.libreFranklin(
    textStyle: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  ),
  overline: GoogleFonts.libreFranklin(
    textStyle: const TextStyle(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
);
