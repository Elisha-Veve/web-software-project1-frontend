import 'package:flutter/material.dart';

class MyThemes {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: const ColorScheme.light().copyWith(
        primary: const Color(0xFF049DBF),
        secondary: const Color(0xFF025E73),
      ));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF053B52),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: const Color(0xFF89CAD9),
        secondary: const Color(0xFFEEECEA),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.resolveWith((state) => Colors.white)),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.resolveWith((state) => Colors.white))));
}
