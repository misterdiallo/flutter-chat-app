import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/user/user.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/user/user_preferences.dart';
import 'package:flutter_chat_app_ui/screens/auth/login_page.dart';
import 'package:flutter_chat_app_ui/screens/widgets/appbar_widget.dart';
import 'widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            buildAppBar(
              context,
              true,
              rightIcon: Icons.logout_outlined,
              functionRightButton: () => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }), (Route<dynamic> route) => false),
              backbuton: IconButton(
                onPressed: () {
                  AdaptiveTheme.of(context).mode.isDark
                      ? AdaptiveTheme.of(context).setLight()
                      : AdaptiveTheme.of(context).setDark();
                },
                icon: const Icon(Icons.mode_night_outlined),
              ),
            ),
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            // NumbersWidget(),
            // const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}
