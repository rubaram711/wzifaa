import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../widgets/reusable_button.dart';
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
              ReusableCareerCard(infoMap: args, isWeInDetailsPage: true),
              const SizedBox(height: 10,),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    '${args['location']}',
                    style: const TextStyle(
                        color: Colors.black,
                    ),
                  )),
              const SizedBox(height: 5,),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  //location
                  child: Text(
                    'المسمى الوظيفي:${args['jop_name']}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 5,),
              const Text(
                'المؤهلات المطلوبة:',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                itemCount: args['Qualification']!.length,
                itemBuilder: (context, index) => Row(
                  children: [
                    const SizedBox(width: 10,),
                    const Text('.',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 15, 0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          '${args['Qualification'][index]}',
                          style: const TextStyle(fontSize: 13, color: Colors.black),
                        )),
                  ],
                ),
              )),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: ReUsableTextButton(
                  text: 'التقديم السريع للوظيفة',
                  isUnderLined: true,
                  isGrey: false,
                  onPress: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
