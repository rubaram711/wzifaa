import 'package:flutter/material.dart';

import '../consts/colors.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 70,
          width: 250,
          child: Image.asset('assets/images/logo.png')),
    );
  }
}



class LogoWithBlueName extends StatelessWidget {
  const LogoWithBlueName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 70,
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'wzifaa',
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,
                  color: kLogoColor,
                  fontFamily: 'Roboto',
                ),
              ),
              Image.asset('assets/images/logo_circle.png'),
            ],
          )),
    );
  }
}