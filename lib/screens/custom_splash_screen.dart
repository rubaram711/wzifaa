import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';

import '../widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate=false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  color: kBasicColor,
  child:   Stack(
    alignment: Alignment.center,
    children: [
      AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          bottom:animate? 300 :-170,
          child: const Logo())
    ],
  ),
),
    );
  }

  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {animate=true;});
    await Future.delayed(const Duration(milliseconds: 1000));
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/login');
  }
}
