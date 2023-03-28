import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazefaa/screens/authentication/login_screen.dart';
import '../consts/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/images/logo.png'),
        nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: kSecondaryColor);
  }
}




