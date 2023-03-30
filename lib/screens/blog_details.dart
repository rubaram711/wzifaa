import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
      body:  Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15,10,15,0),
            child:  Html(
              data: args!['content'],
            ),
          ),
        ),
      ),
    );
  }
}
