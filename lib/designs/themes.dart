import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: appActiveColor,
    // Define the default font family.
    // fontFamily: 'Raleway Dots',
    scaffoldBackgroundColor: appBbackground,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      iconTheme: IconThemeData(
        color: AppColors.whitegrey.withOpacity(0.7),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.white,
      secondary: AppColors.primaryLight,
    ),
    cardTheme: const CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: AppColors.greyshade600,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryDark,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.greyshade600,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w200),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle1: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryLight,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: const CardTheme(
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white54,
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}
