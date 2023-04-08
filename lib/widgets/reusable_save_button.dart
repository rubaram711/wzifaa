import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
class ReusableSaveButton extends StatelessWidget {
  const ReusableSaveButton({Key? key, required this.onPress}) : super(key: key);
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPress();
      },
      child: Row(
        children: const[
           Icon(
            Icons.favorite,
            color: kSecondaryColor,
            size: 17,
          ),
          SizedBox(width: 5,),
          Text('حفظ',style: TextStyle(color: kSecondaryColor,),),
        ],
      ),
    );
  }
}
