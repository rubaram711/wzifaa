import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
class ReusableShareButton extends StatelessWidget {
  const ReusableShareButton({Key? key,
   required this.shareFunction
  }) : super(key: key);
  final Function shareFunction;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        shareFunction();
      },
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
