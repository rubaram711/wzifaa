// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import '../backend/get_user_by_id.dart';
import '../backend/save_user_info_locally.dart';
import '../backend/update_user_info.dart';
import '../consts/colors.dart';
import '../widgets/reusable_alert.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_text_field.dart';
import 'authentication/login_screen.dart';
String name='';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _email = '';
  String _username = '';
  String? _phone = '';
  String? id;
  getInfoFromPref() async {
    String id2 = await getIdFromPref();
    setState(() {
      id = id2;
    });
  }

  Map profileInfoMap = {};
  bool isUserInfoFetched = false;
  bool showPageContent = false;
  getUserInfo() async {
    await getInfoFromPref();
      Map p = await getUserById(id);
      setState(() {
        profileInfoMap = p;
        isUserInfoFetched = true;
      });
    setState(() {
      showPageContent = true;
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOfWhiteBgColor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'الحساب الشخصي',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body:showPageContent? Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key:   _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Center(
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       hasImage == false
                //           ? _imageFile == null
                //               ? CircleAvatar(
                //                   backgroundColor: kBgColor,
                //                   radius: 65,
                //                   child:Image.asset('assets/images/user_icon.png'))
                //               : CircleAvatar(
                //                   backgroundColor: kBgColor,
                //                   radius: 65,
                //                   child: ClipOval(
                //                       child: Image.file(
                //                     _imageFile!,
                //                     fit: BoxFit.cover,
                //                     height: 130,
                //                     width: 130,
                //                   )),
                //                 )
                //           : CircleAvatar(
                //               backgroundColor: kBasicColor,
                //               radius: 65,
                //               child: ClipOval(
                //                   child: //Container(),
                //                       Image.asset(
                //                 'assets/images/profile.jpg',
                //                 fit: BoxFit.cover,
                //                 height: 130,
                //                 width: 130,
                //               )),
                //             ),
                //       Positioned(
                //         bottom: 3.0,
                //         left: 0.0,
                //         child: InkWell(
                //           onTap: () {
                //             goTOGallery();
                //           },
                //           child: CircleAvatar(
                //             radius: 16,
                //             backgroundColor: Colors.grey[600],
                //             child: const Icon(
                //               Icons.camera_alt,
                //               color: Colors.white,
                //               size: 20.0,
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                ReusableTextFieldForProfile(
                    hintText: profileInfoMap['user_name'],
                    onChangedFunc: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                    text: 'اسم المستخدم'),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextFieldForProfile(
                    hintText: profileInfoMap['user_phone'].toString(),
                    onChangedFunc: (value) {
                      setState(() {
                        _phone = value.toString();
                      });
                    },
                    text: 'رقم الهاتف'),
                const SizedBox(
                  height: 20,
                ),
                ReusableTextFieldForProfile(
                    hintText: profileInfoMap['user_email'],
                    onChangedFunc: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    text: 'البريد الإلكتروني'),
                const SizedBox(
                  height: 25,
                ),
                ReUsableButtonWithRoundedCorner(
                  text: 'حفظ',
                  onPressButton: () async {
                    _id = profileInfoMap['ID'];
                    if(_username==''){setState(() {
                      _username=profileInfoMap['user_name'];
                    });}
                     if(_email==''){setState(() {
                      _email=profileInfoMap['user_email'];
                    });}
                     if(_phone==''){setState(() {
                      _phone=profileInfoMap['user_phone'];
                    });}

                    print(_id);
                    var response =
                        await updateUserInfo(_id, _email, _username, _phone);
                    if(response=={"msg":"Access denied"}){
                      // ignore: use_build_context_synchronously
                      alert(context, 'فشل التعديل عليك إعادة تسجيل الدخول');
                      //ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false);
                    }
                    else{
                      // ignore: use_build_context_synchronously
                      alert(context, 'تم التعديل بنجاح');
                      setState(() {
                        name=_username;
                      });
                    }
                  },
                )
              ]),
            ),
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }

//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   bool hasImage = false;
//   goTOGallery() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         hasImage = false;
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

}
