import 'package:flutter/material.dart';

import '../consts/colors.dart';



class ReusableTextField extends StatefulWidget {
  const ReusableTextField({super.key,
    required this.onChangedFunc,
    required this.validationFunc, required this.text, required this.isPasswordField, required this.isEnabled,
  });
  final Function onChangedFunc;
  final Function validationFunc;
  final String text;
  final bool isPasswordField;
final bool isEnabled;

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection:TextDirection.rtl,
      cursorColor: kBasicColor,
      style: const TextStyle(
          color: Colors.black,
          fontSize: 14
      ),
      obscureText:widget.isPasswordField? !showPassword:false,
      decoration: InputDecoration(
        hintText: widget.text,
        labelText: widget.text,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey[700]
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon:widget.isPasswordField?
        IconButton(
          onPressed: (){
           setState(() {
             showPassword=!showPassword;
           });
          },
          icon:Icon(
            showPassword? Icons.visibility_off: Icons.visibility,
          color: Colors.grey,
          size: 23,
          ),
        ):null,
        contentPadding: const EdgeInsets.fromLTRB(5,0,26,5),
        border: const OutlineInputBorder(
          borderSide:BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorStyle:const TextStyle(
          fontSize: 10.0,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
      ),
      enabled:widget.isEnabled,
      validator:(value){
        return widget.validationFunc(value);
      },
      onChanged:(value)=>widget.onChangedFunc(value),
    );
  }
}



class ReusableTextFieldForProfile extends StatelessWidget {
  const ReusableTextFieldForProfile({Key? key, required this.onChangedFunc, required this.text, required this.hintText}) : super(key: key);
  final Function onChangedFunc;
  final String text;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
        const SizedBox(height: 10,),
        TextFormField(
          key: Key(hintText.toString()), //////
          textDirection:TextDirection.rtl,
          cursorColor: kBasicColor,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14
          ),
          keyboardType:text=='رقم الهاتف'? TextInputType.number:
          text=='البريد الإلكتروني'? TextInputType.emailAddress :TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(5,15,26,15),
            focusedBorder: const OutlineInputBorder(
                borderSide:BorderSide(
                  color: kBasicColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder:  const OutlineInputBorder(
              borderSide:BorderSide(
               color: kBgColor,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          onChanged:(value){onChangedFunc(value);},
        ),
      ],
    );
  }
}






