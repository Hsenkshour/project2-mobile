import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    final primaryColor = Colors.yellow[600];
    final accentColor = Colors.yellow[600];

    return ThemeData(
      primaryColor: primaryColor,
      primarySwatch: Colors.yellow,
      hintColor: accentColor,
      colorScheme: ThemeData.light().colorScheme.copyWith(
        secondary: accentColor,
      ),
      fontFamily: 'Montserrat',
    );
  }
}
