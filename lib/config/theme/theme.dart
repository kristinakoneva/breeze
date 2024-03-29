import 'package:breeze/config/theme/colors.dart';
import 'package:flutter/material.dart';

/// A class providing the theme configuration for the application.
ThemeData theme() {
  /// Returns a customized [ThemeData] for the application.
  ///
  /// The theme includes color schemes, button styles, text themes, icon styles,
  /// dialog themes, and an app bar theme.
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
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: colorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      contentTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: appBarTheme(),
    useMaterial3: true,
  );
}

/// Returns a customized [AppBarTheme] for the application's app bar.
///
/// The app bar theme includes color, elevation, centering title, and text styles.
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
