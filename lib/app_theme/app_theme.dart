import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: Colors.purple,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: _appBarTheme,
    colorScheme: ColorScheme.dark(
      primary: Colors.purple,
    ),
  );

  static const _appBarTheme = AppBarTheme(
    centerTitle: true,
  );
}
