import 'package:flutter/material.dart';

class AppTheme {
  static const primaryBlue = Color(0xFF3F6FAA);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBlue,
      brightness: Brightness.light,
      primary: primaryBlue,
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
    listTileTheme: const ListTileThemeData(iconColor: primaryBlue),
  );
}
