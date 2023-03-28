import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';

Widget reusableBackArrow(Function onPressFunction) {
  return InkWell(
    onTap: () {
      onPressFunction();
    },
    child: Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffBDC6CF),
            borderRadius: BorderRadius.circular(7)),
        margin: const EdgeInsets.only(top: 30,),
        width: 35,
        height: 35,
        child: const Center(
          child: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: kBasicColor,
            size: 30,
          ),
        ),
      ),
    ),
  );
}
