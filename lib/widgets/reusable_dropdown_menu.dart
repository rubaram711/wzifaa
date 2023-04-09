import 'package:flutter/material.dart';

import '../consts/colors.dart';



class ReusableDropdownButton extends StatelessWidget {
  const ReusableDropdownButton({super.key, required this.hint, required this.list, required this.dropdownValue, required this.onChangeFunction, required this.isItemSelected});
 final String hint;
 final List<String> list;
 final  String dropdownValue;
 final Function onChangeFunction;
 final bool isItemSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      height: 40,
      padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin:const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: isItemSelected?dropdownValue:null,
          isExpanded: true,
          hint: Text(hint),
          style: const TextStyle(color: kBasicColor),
          onChanged: (String? value) {
            onChangeFunction(value);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
