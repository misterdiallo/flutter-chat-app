import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/designs/themes.dart';
import 'package:flutter_chat_app_ui/screens/homepage.dart';

class AppStartPage extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const AppStartPage({
    super.key,
    this.savedThemeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App UI',
        theme: theme,
        darkTheme: darkTheme,
        home: const HomePage(),
        // home: const LoginPage(),
      ),
    );
  }
}
