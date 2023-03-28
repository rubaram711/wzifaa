import 'package:flutter/material.dart';

import '../consts/colors.dart';

class ReusableOptionCard extends StatelessWidget {
  const ReusableOptionCard({Key? key, required this.onTapFunction, required this.icon, required this.text}) : super(key: key);
final Function onTapFunction;
final IconData icon;
final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapFunction();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              //offset: Offset(0, 15),
              blurRadius: 20,
              color: Colors.grey.shade200,
            ),
          ],
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,color: kBasicColor,size: 20,),
                const SizedBox(width: 10,),
                Text(text,style: const TextStyle(color: kBasicColor, fontSize: 14,fontWeight: FontWeight.bold),),
              ],
            ),
            const Icon(Icons.arrow_back_ios_new,color: kSecondaryColor,size: 20,),
          ],
        ),
      ),
    );
  }
}
