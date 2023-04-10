import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wazefaa/backend/save_user_info_locally.dart';
import '../backend/get_user_by_id.dart';
import '../consts/URLs.dart';
import '../consts/colors.dart';
import '../widgets/reusable_option_card.dart';
import 'authentication/login_screen.dart';

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
  bool isThisVisitor = false;
  bool showPageContent = false;
  getUserInfo() async {
    await getInfoFromPref();
    if (id != '') {
      Map p = await getUserById(id);
      setState(() {
        profileInfoMap = p;
        isUserInfoFetched = true;
      });
    } else {
      setState(() {
        isThisVisitor = true;
      });
    }
    setState(() {
      showPageContent = true;
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
      child: showPageContent
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
                      child: isThisVisitor
                          ? ClipOval(
                              child: Image.asset(
                              'assets/images/user_icon.png',
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ))
                          : ClipOval(
                              child: Image.asset(
                              'assets/images/user_icon.png',
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مرحبا,',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        isThisVisitor
                            ? const SizedBox()
                            : Text(
                                profileInfoMap['user_name'],
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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false);
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
                      isThisVisitor
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
                      role == 'employer'|| !isThisVisitor
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
                        onTapFunction:  ()async{
                          // await launchUrl(Uri.parse(infoMap['link']),);
                          if (await canLaunchUrl(Uri.parse(addCvUrl))) {
                            await launchUrl( Uri.parse(addCvUrl),mode: LaunchMode.externalApplication );
                          } else { throw 'There was a problem to open the url: $addCvUrl'; }
                        },
                      ),
                      ReusableOptionCard(
                        icon: Icons.favorite_border,
                        text: 'المفضلة',
                        onTapFunction: () {
                          Navigator.pushNamed(context, '/favorite');
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
                          Share.share(
                              'https://play.google.com/store/apps/details?id=com.wzifaa.app');
                        },
                      ),
                    ],
                  )),
            )
          : const SizedBox(),
    );
  }
}
