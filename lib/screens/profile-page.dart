import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../backend/update_user_info.dart';
import '../consts/colors.dart';
import '../widgets/reusable_alert.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_text_field.dart';

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
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key:   _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      hasImage == false
                          ? _imageFile == null
                              ? CircleAvatar(
                                  backgroundColor: kBgColor,
                                  radius: 65,
                                  child:Image.asset('assets/images/user_icon.png'))
                              : CircleAvatar(
                                  backgroundColor: kBgColor,
                                  radius: 65,
                                  child: ClipOval(
                                      child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                    height: 130,
                                    width: 130,
                                  )),
                                )
                          : CircleAvatar(
                              backgroundColor: kBasicColor,
                              radius: 65,
                              child: ClipOval(
                                  child: //Container(),
                                      Image.asset(
                                'assets/images/profile.jpg',
                                fit: BoxFit.cover,
                                height: 130,
                                width: 130,
                              )),
                            ),
                      Positioned(
                        bottom: 3.0,
                        left: 0.0,
                        child: InkWell(
                          onTap: () {
                            goTOGallery();
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey[600],
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ReusableTextFieldForProfile(
                    hintText: args!['user_name'],
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
                    hintText: args['user_phone'].toString(),
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
                    hintText: args['user_email'],
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
                    //{msg: updated}

                    _id = args['ID'];
                    var response =
                        await updateUserInfo(_id, _email, _username, _phone);
                    if(response=={'msg': 'updated'}){
                      // ignore: use_build_context_synchronously
                      alert(context, 'تم التعديل بنجاح');
                    }
                    else{
                      // ignore: use_build_context_synchronously
                      alert(context, 'فشل التعديل جرب إعادة تسجيل الدخول');
                    }
                  },
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool hasImage = false;
  goTOGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        hasImage = false;
        _imageFile = File(pickedFile.path);
      });
    }
  }
}
