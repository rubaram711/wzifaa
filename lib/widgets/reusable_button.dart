import 'package:flutter/material.dart';

import '../consts/colors.dart';

class ReUsableButton extends StatelessWidget {
  const ReUsableButton({super.key, required this.text,required this.onPressButton});
  final String text;
  final Function onPressButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          onPressButton();
        },
      style: ElevatedButton.styleFrom(
          backgroundColor: kBasicColor,
          minimumSize:const Size.fromHeight(50), //MediaQuery.of(context).size*0.06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),

      ),
      child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    );
  }
}

class ReUsableButtonWithRoundedCorner extends StatelessWidget {
  const ReUsableButtonWithRoundedCorner({super.key, required this.text,required this.onPressButton});
  final String text;
  final Function onPressButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          onPressButton();
        },
      style: ElevatedButton.styleFrom(
          backgroundColor: kThirdColor,
          minimumSize:const Size.fromHeight(50), //MediaQuery.of(context).size*0.06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

      ),
      child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    );
  }
}




class ReUsableTextButton extends StatelessWidget {
  const ReUsableTextButton({super.key, required this.text, required this.onPress, required this.isGrey, required this.isUnderLined});
  final String text;
  final Function onPress;
 final bool isGrey;
 final bool isUnderLined;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        onPress();
      },
      child: Text(text,
        style: TextStyle(
            fontSize: 15,
            decoration:isUnderLined? TextDecoration.underline:TextDecoration.none,
            fontWeight: FontWeight.bold,
            color:isGrey? Colors.grey: kThirdColor
        ),
      ),
    );
  }
}