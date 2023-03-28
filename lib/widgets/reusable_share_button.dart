import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
class ReusableShareButton extends StatelessWidget {
  const ReusableShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){},
      child: Row(
        children: const[
           Icon(
            Icons.share,
            color: kSecondaryColor,
            size: 17,
          ),
          SizedBox(width: 5,),
          Text('شارك',style: TextStyle(color: kSecondaryColor),),
        ],
      ),
    );
  }
}
