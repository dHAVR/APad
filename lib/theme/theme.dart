import 'package:flutter/material.dart';

//light mode
ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color(0xFFFDEFDA),
      primary: Color(0xFFD8B89A),
      secondary: Color(0xFFFCFCFC),
      inversePrimary: Color(0xFF313131),
    ));

//dark mode
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF1E1E1E),
      primary: Color(0xFF676767),
      secondary: Color(0xFF737373),
      inversePrimary: Color(0xFFF5F5F5),
    ));
