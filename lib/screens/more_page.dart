import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../widgets/reusable_option_card.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Map profileInfoMap={
    'image':'assets/images/profile.jpg',
    'name':'سامي حمد'
  };
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kOfWhiteBgColor,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight:MediaQuery.of(context).size.height*0.10,
          backgroundColor: kBasicColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: ClipOval(
                      child: Image.asset(profileInfoMap['image'],fit: BoxFit.cover,height: 50,width: 50,)
                  ),
            ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text('مرحبا,',
                    style: TextStyle(color: Colors.white,fontSize: 14),),
                  Text(
                      profileInfoMap['name'],
                    style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, '/');
            }, icon:const Icon(Icons.logout,color: Colors.white,size: 25,))
          ],
        ),
        body: Container(
            margin:const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.fromLTRB(15,10,15,0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                ReusableOptionCard(
                  icon: Icons.person_outline,
                  text: 'الحساب الشخصي',
                  onTapFunction: (){
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ReusableOptionCard(
                  icon: Icons.event_note,
                  text: 'السير الذاتية',
                  onTapFunction: (){
                    Navigator.pushNamed(context, '/CVs');
                  },
                ),
                ReusableOptionCard(
                  icon: Icons.add_comment,
                  text: 'إضافة وظيفة',
                  onTapFunction: (){
                    Navigator.pushNamed(context, '/add_job');
                  },
                ),
                ReusableOptionCard(
                  icon: Icons.add_card,
                  text: 'إضافة سيرة ذاتية',
                  onTapFunction: (){
                     //Navigator.pushNamed(context, '/add_cv');
                  },
                ),
                ReusableOptionCard(
                  icon: Icons.phone,
                  text: 'تواصل معنا',
                  onTapFunction: (){
                    Navigator.pushNamed(context, '/contact_us');
                  },
                ),
                ReusableOptionCard(
                  icon: Icons.share,
                  text: 'مشاركة التطبيق',
                  onTapFunction: (){
                    //todo
                    // Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            )),
      ),
    );
  }
}
