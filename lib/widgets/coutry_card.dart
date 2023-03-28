import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';

class CountryCard extends StatefulWidget {
  const CountryCard({Key? key, required this.countryName}) : super(key: key);
  final String countryName;
  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  var _oneValue = '';
  @override
  Widget build(BuildContext context) {
    return RadioListTile(title: Text(widget.countryName,style: const TextStyle(fontSize: 14,color: kThirdColor,fontWeight: FontWeight.bold),),
      value: widget.countryName,
      groupValue: _oneValue,
      onChanged: (value) {
        setState(() {
          _oneValue = value.toString();
        });
      },
    );
  }
}
