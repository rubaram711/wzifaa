import 'package:flutter/material.dart';

void alert(context,String text){
  ScaffoldMessenger.of(context)
      .showSnackBar( SnackBar(
    content: Text(
        text),
    //backgroundColor: kAlertColor,
  ));
}