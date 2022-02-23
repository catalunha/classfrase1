import 'package:flutter/material.dart';

final ThemeData appThemeDataOrange = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.orange,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: Colors.cyan[600],
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.orange,
  ),
);

final ThemeData appThemeDataDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  primarySwatch: Colors.green,
);
