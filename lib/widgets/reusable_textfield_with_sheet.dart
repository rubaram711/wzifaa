import 'package:flutter/material.dart';

import '../consts/colors.dart';


String option='الخيارت';
class ReusableTextFieldWithSheet extends StatefulWidget {
  const ReusableTextFieldWithSheet({
    super.key,
    required this.onChangedFunc,
    required this.validationFunc,
    required this.text,
  });
  final Function onChangedFunc;
  final Function validationFunc;
  final String text;

  @override
  State<ReusableTextFieldWithSheet> createState() =>
      _ReusableTextFieldWithSheetState();
}

class _ReusableTextFieldWithSheetState
    extends State<ReusableTextFieldWithSheet> {
  String text = '', selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context, builder: (context)=> _buildBottomSheetForOptions(context));
      },
      child: TextFormField(
        textDirection: TextDirection.rtl,
        cursorColor: kBasicColor,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          hintText: option,
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                text = selectedOption;
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 25,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(5, 0, 26, 5),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        enabled: false,
        onChanged: (value) => widget.onChangedFunc(value),
      ),
    );
  }

  SizedBox _buildBottomSheetForOptions(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      //padding: const EdgeInsets.all(10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: kBasicColor,
              child: const Center(
                child: Text('الخيارات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        option='نحن منشأة أو من يمثلها تبحث عن موظفين';
                        Navigator.pop(context);
                      });
                    },
                      child: const Text('نحن منشأة أو من يمثلها تبحث عن موظفين',style: TextStyle(fontSize: 16),)),
                  const SizedBox(height: 20,),
                  InkWell(
                      onTap: (){
                        setState(() {
                          option='أنا شخص أبحث عن عمل';
                          Navigator.pop(context);
                        });
                      },child: const Text('أنا شخص أبحث عن عمل',style: TextStyle(fontSize: 16),)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
