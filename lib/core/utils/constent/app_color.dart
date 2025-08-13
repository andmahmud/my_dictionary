import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xffBF0000);
  static Color secondary = Color(0xff031F8D);

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xfffffa9e), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  // Text Colors
  static const Color textPrimary = Color(0xff1E2124);
  static const Color textSecondary = Color(0xFF636F85);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border
  static const Color textFieldBorder = Color(0xFFE2E8F0);
  static const Color buttonBorder = Color(0xFFD1D6DB);

  // added by shahriar
  static const Color containerBorder = Color(0xFFdcdcdf);

  // Background Colors
  static const Color primaryBackGround = Color(0xFFFFFFFF);

  /// textformfield border color
  static const Color textFormFieldBorder = Color(0xFFD9D9D9);

  // Button
  static const Color primaryButton = Color(0xffBF0000);

  static const Color fillcolor = Color(0xffF9FAFB);


}
