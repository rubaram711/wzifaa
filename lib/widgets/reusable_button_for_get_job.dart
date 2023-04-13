import 'package:flutter/material.dart';

class ReusableButtonForGetJob extends StatelessWidget {
  const ReusableButtonForGetJob({Key? key, required this.text, required this.type, required this.onPressFunc}) : super(key: key);
   final String text;
   final String type;
   final Function onPressFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      child: Stack(
        children: [
          Positioned(
            right: 25,
            top: 3,
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.7,
              child: ElevatedButton(
                onPressed: () {
                  onPressFunc();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:type=='whatsapp'? Colors.green
                      :type=='email'?Colors.red
                      : type=='phone'?Colors.orange
                      : Colors.lightBlue,
                  //padding:const EdgeInsets.symmetric(horizontal: 40),

                ),
                child: Text(text),
              ),
            ),
          ),
          CircleAvatar(
              backgroundColor: Colors.black45,
              radius: 25,
              child: CircleAvatar(
                backgroundColor:Colors.white,
                radius: 24,
                child: type=='whatsapp'?const Icon(Icons.whatsapp,color: Colors.green,size: 35,)
                    :type=='email'?const Icon(Icons.email_outlined,color:Colors.red,size: 35,)
                    :type=='phone'?const Icon(Icons.phone,color:Colors.orange,size: 35,)
                    : const Icon(Icons.language,color: Colors.lightBlue,size: 35,),
              )
          ),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: type=='whatsapp'?const Icon(Icons.whatsapp)
          //   :type=='email'?const Icon(Icons.email_outlined)
          //   :const Icon(Icons.language),
          //   label: Text(text),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor:type=='whatsapp'? Colors.green :
          //     type=='email'?Colors.red:Colors.lightBlue,
          //   ),
          // ),
        ],
      ),
    );
  }
}
