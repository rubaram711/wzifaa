import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';

import '../widgets/reusable_CV_card.dart';

class CVsPage extends StatefulWidget {
  const CVsPage({Key? key}) : super(key: key);

  @override
  State<CVsPage> createState() => _CVsPageState();
}

class _CVsPageState extends State<CVsPage> {
  List cvsList=[{
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },
  {
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },
  {
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },
  {
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },
  {
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },
  {
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد',
    'jop':'Product Designer',
    'location': 'الامارات العربية المتحدة',
    'review':'21'
  },



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'السير الذاتية',
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
            margin:const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.fromLTRB(15,10,15,0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: cvsList.length,
              itemBuilder: (context, index) => ReusableCvCard(
                infoMap: cvsList[index],
              ),
            )),
      ),
    );
  }
}
