import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: appActiveColor,
    // Define the default font family.
    fontFamily: 'NanumGothic',
    scaffoldBackgroundColor: appBbackground,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      iconTheme: IconThemeData(
        color: AppColors.whitegrey.withOpacity(0.7),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.white,
      secondary: AppColors.primaryLight,
    ),
    cardTheme: const CardTheme(),
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
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        shape: const ContinuousRectangleBorder(),
        elevation: 10,
        shadowColor: AppColors.primaryDark,
        fixedSize: const Size(double.maxFinite, 50),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.greyshade600,
      //  shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.accent,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 93,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: AppColors.white0,
      ),
      headline2: TextStyle(
        fontSize: 58,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: AppColors.white0,
      ),
      headline3: TextStyle(fontSize: 47, fontWeight: FontWeight.w400),
      headline4: TextStyle(
        fontSize: 33,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.white0,
      ),
      headline5: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w400,
        color: AppColors.white0,
      ),
      headline6: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.white0,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),

      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
      // displayLarge: const TextStyle(),
      // displayMedium: const TextStyle(),
      // displaySmall: const TextStyle(),
      // headline1: TextStyle(),
      // headline2: TextStyle(),
      // headline3: TextStyle(),
      // headline4: TextStyle(),
      // headline5: TextStyle(),
      // headline6: TextStyle(),
      // titleLarge: const TextStyle(),
      // titleMedium: const TextStyle(),
      // titleSmall: const TextStyle(),
      // labelLarge: const TextStyle(),
      // labelMedium: const TextStyle(),
      // labelSmall: const TextStyle(),
      // bodyLarge: const TextStyle(),
      // bodyMedium: const TextStyle(),
      // bodySmall: const TextStyle(),
      // bodyText1: TextStyle(),
      // bodyText2: TextStyle(),
      // subtitle1: TextStyle(),
      // subtitle2: TextStyle(),
      // overline: TextStyle(),
      // button: TextStyle(),
      // caption: TextStyle(),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    // Define the default font family.
    // fontFamily: 'Raleway Dots',
    scaffoldBackgroundColor: AppColors.white0,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      iconTheme: IconThemeData(
        color: AppColors.primaryLight.withOpacity(0.7),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.black,
      secondary: AppColors.primaryGrey,
    ),
    cardTheme: const CardTheme(),
    iconTheme: IconThemeData(
      color: AppColors.greyshade600,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.greyshade600,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w200),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        shape: const ContinuousRectangleBorder(),
        elevation: 10,
        foregroundColor: AppColors.white0,
        shadowColor: AppColors.primaryDark,
        fixedSize: const Size(double.maxFinite, 50),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.greyshade600,
      //  shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.accent,
    ),
  );
}
