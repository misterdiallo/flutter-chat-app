import 'package:flutter/material.dart';

const appBbackground = AppColors.primaryDark;
const appTextColor = AppColors.white;
const appActiveColor = AppColors.primaryLight;
const appTransparent = Colors.transparent;

class AppColors {
  //! Primary
  static const Color primaryDark = Color.fromRGBO(10, 23, 30, 1);
  static const Color primaryLight = Color.fromRGBO(0, 112, 218, 1);
  static const Color primaryGrey = Color.fromRGBO(61, 70, 72, 1);
  static const Color primaryBleuBic = Color.fromARGB(255, 39, 79, 122);

  //! Normal
  static const Color transparent = Colors.transparent;
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static Color greyshade600 = Colors.grey.shade600;
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color white0 = Color.fromARGB(212, 255, 255, 255);
  static const Color whitegrey = Color.fromARGB(166, 220, 220, 220);
  static const Color red = Color.fromRGBO(255, 0, 0, 1);
}
