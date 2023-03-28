import 'package:flutter/material.dart';

import '../consts/colors.dart';

class BlogDetails extends StatelessWidget {
  const BlogDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'تفاصيل المدونة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15,10,15,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(args!['description'], style:const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
              Text(args['jop'], style:const TextStyle(color: Colors.black),),
              const Text('المؤهلات المطلوبة:', style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
              Container(
                  padding:const EdgeInsets.fromLTRB(15,15,15,0),
                  child: Text(args['Qualification'], style:const TextStyle(fontSize:13,color: Colors.black),)),
            ],
          ),
        ),
      ),
    );
  }
}
