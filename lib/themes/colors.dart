import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Colors.black;
  static const Color onPrimary = Colors.white;
  static const Color secondary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color error = Color(0xFFF95B51);
  static const Color onError = Colors.white;
  static const Color surface = Color.fromARGB(255, 247, 246, 246);
  static const Color onSurface = Colors.black;
  static const Color dbBalanceColor = Color(0xFF25A969);

  ThemeData toTheme() {
    return ThemeData.from(
        textTheme: toTextTheme(),
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: primary,
            onPrimary: onPrimary,
            secondary: secondary,
            onSecondary: onSecondary,
            error: error,
            onError: onError,
            surface: surface,
            onSurface: onSurface),
        useMaterial3: true);
  }

  TextTheme toTextTheme() {
    return GoogleFonts.montserratTextTheme().copyWith(
        titleMedium: GoogleFonts.montserrat()
            .copyWith(color: Colors.black, fontWeight: FontWeight.bold));
  }
}
