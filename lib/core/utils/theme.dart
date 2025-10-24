import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: Color.fromRGBO(0, 45, 114, 1),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromRGBO(0, 45, 114, 1),
    selectionColor: Color.fromRGBO(3, 189, 205, 1),
    selectionHandleColor: Color.fromRGBO(0, 0, 0, 1),
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Color.fromRGBO(0, 45, 114, 1),
    actionsIconTheme: IconThemeData(color: Colors.white),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w300,
    ),
  ),
);
