import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../consts/colors.dart';
//import '../widgets/reusable_button.dart';
import '../widgets/reusable_career_card.dart';

class CareerDetails extends StatelessWidget {
  const CareerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: Text(
          args!['company'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: ListView(
            children: [
              ReusableCareerCard(
                  id: args['id'],
                  title: args['title'],
                  date: args['date'],
                  content: args['content'],
                  company: args['company'],
                  location: args['location'],
                  views: args['views'],
                  logo: args['logo'],
                  isWeInDetailsPage: true),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                child: Html(
                  data: args['content'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
