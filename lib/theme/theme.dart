import 'package:flutter/material.dart';

//light mode
ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color(0xFFEADBC8),
      primary: Color(0xFFB5C18E),
      secondary: Color(0xFFF1F1F1),
      inversePrimary: Color(0xFF313131),
    ));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF1E1E1E),
      primary: Color(0xFFB0B0B0),
      secondary: Color(0xFF90A4AE),
      inversePrimary: Color(0xFF5A5A5A),
    ));
