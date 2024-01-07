import 'package:breeze/config/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: colorPrimary,
      primary: colorPrimary,
      onSurface: colorSurface,
    ),
    scaffoldBackgroundColor: colorSurface,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorPrimary,
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: appBarTheme(),
    useMaterial3: true,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: colorSurface,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}
