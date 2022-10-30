import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // late AnimationController _myAnimationController;
  late Animation<double> logoOpacityAnimation;
  late Animation<Offset> logoAnimation;
  late Animation<double> logoSizeAnimation;
  late Animation<double> commonFadeSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    logoAnimation = Tween<Offset>(
      begin: const Offset(0.0, 3.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.7, curve: Curves.decelerate),
      ),
    );
    logoOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.9, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );
    logoSizeAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.55, 0.85, curve: Curves.decelerate),
      ),
    );
    commonFadeSlideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.55, 0.9, curve: Curves.decelerate),
      ),
    );

    _animationController.forward();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    //! LOGO
                    SlideTransition(
                      position: logoAnimation,
                      child: Opacity(
                        opacity: 1.0,
                        child: Image.asset(
                          "assets/svg/girl_sit.png",
                          width: 180,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SlideFadeWidget(
                      commonFadeSlideAnimation: commonFadeSlideAnimation,
                      child: SizedBox(
                        // width: 450,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "TALK WITH",
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              ),
                              TextField(
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyshade600,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.greyshade600),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primaryLight),
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !showPassword,
                                decoration: InputDecoration(
                                  suffixIconColor: AppColors.greyshade600,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      end: 12.0,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        showPassword
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyshade600,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.greyshade600),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primaryLight),
                                  ),
                                  floatingLabelStyle: const TextStyle(
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ElevatedButton(
                                style:
                                    Theme.of(context).outlinedButtonTheme.style,
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      PageRouteBuilder(
                                          pageBuilder: (context, firstAnimation,
                                              secondaryAnimation) {
                                            return const HomePage();
                                          },
                                          transitionDuration:
                                              const Duration(seconds: 1)),
                                      (Route<dynamic> route) => false);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              // Text(
                              //   "Forgot your password?",
                              //   style: TextStyle(color: AppColors.greyshade600),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class SlideFadeWidget extends StatelessWidget {
  const SlideFadeWidget({
    Key? key,
    required this.commonFadeSlideAnimation,
    required this.child,
  }) : super(key: key);

  final Animation<double> commonFadeSlideAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          MediaQuery.of(context).size.width *
              (1 - commonFadeSlideAnimation.value),
          10),
      child: Opacity(
        opacity: commonFadeSlideAnimation.value,
        child: child,
      ),
    );
  }
}
