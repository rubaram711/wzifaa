import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:wazefaa/backend/save_user_info_locally.dart';

import '../backend/get_user_by_id.dart';
import '../consts/colors.dart';
import '../widgets/reusable_option_card.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String? role;
  String? id;
  getInfoFromPref() async {
    String r = await getRoleFromPref();
    String id2 = await getIdFromPref();
    setState(() {
      role = r;
      id = id2;
    });
  }

  Map profileInfoMap = {};
  bool isUserInfoFetched = false;
  getUserInfo() async {
    await getInfoFromPref();
    Map p = await getUserById(id);

    setState(() {
      profileInfoMap = p;
      isUserInfoFetched = true;
    });
  }

  @override
  void initState() {
    //getInfoFromPref();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: isUserInfoFetched
          ? Scaffold(
              backgroundColor: kOfWhiteBgColor,
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: MediaQuery.of(context).size.height * 0.10,
                backgroundColor: kBasicColor,
                title:
                    //isUserInfoFetched?
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: ClipOval(
                          child: Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مرحبا,',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          profileInfoMap != {}
                              ? profileInfoMap['user_name']
                              : 'user',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                //:const CircularProgressIndicator(color: Colors.white,),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 25,
                      ))
                ],
              ),
              body: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      profileInfoMap['ID'] == ''
                          ? const SizedBox()
                          : ReusableOptionCard(
                              icon: Icons.person_outline,
                              text: 'الحساب الشخصي',
                              onTapFunction: () {
                                Navigator.pushNamed(context, '/profile',
                                    arguments: {
                                      'user_name': profileInfoMap['user_name'],
                                      'user_email':
                                          profileInfoMap['user_email'],
                                      'user_phone':
                                          profileInfoMap['user_phone'] ?? '',
                                      'ID': profileInfoMap['ID'],
                                    });
                              },
                            ),
                      ReusableOptionCard(
                        icon: Icons.event_note,
                        text: 'السير الذاتية',
                        onTapFunction: () {
                          Navigator.pushNamed(context, '/CVs');
                        },
                      ),
                      role == 'employer'
                          ? ReusableOptionCard(
                              icon: Icons.add_comment,
                              text: 'إضافة وظيفة',
                              onTapFunction: () {
                                Navigator.pushNamed(context, '/add_job');
                              },
                            )
                          : const SizedBox(),
                      ReusableOptionCard(
                        icon: Icons.add_card,
                        text: 'إضافة سيرة ذاتية',
                        onTapFunction: () {
                          //Navigator.pushNamed(context, '/add_cv');
                        },
                      ),
                      ReusableOptionCard(
                        icon: Icons.phone,
                        text: 'تواصل معنا',
                        onTapFunction: () {
                          Navigator.pushNamed(context, '/contact_us');
                        },
                      ),
                      ReusableOptionCard(
                        icon: Icons.share,
                        text: 'مشاركة التطبيق',
                        onTapFunction: () {
                          //Share.share('com.example.wazefaa') ;
                          Navigator.pushNamed(context, '/ShareMe');
                        },
                      ),
                    ],
                  )),
            )
          : SizedBox(),
    );
  }
}
