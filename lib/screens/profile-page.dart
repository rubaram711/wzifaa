import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/colors.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15,35,15,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      hasImage == false
                        ? _imageFile == null
                          ? const CircleAvatar(
                          backgroundColor: kBgColor,
                          radius: 65,
                          child: Icon(
                            Icons.person,
                            size: 90,
                            color: Colors.white,
                          ))
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
                const SizedBox(height: 25,),
                ReusableTextFieldForProfile(value: 'سامي حمد',onChangedFunc: (){},text:'اسم المستخدم'),
                const SizedBox(height: 20,),
                ReusableTextFieldForProfile(value: ' +0508090804',onChangedFunc: (){},text:'رقم الهاتف'),
                const SizedBox(height: 20,),
                ReusableTextFieldForProfile(value: 'sami@gmail.com',onChangedFunc: (){},text:'البريد الإلكتروني'),
                const SizedBox(height: 25,),
                ReUsableButtonWithRoundedCorner(text: 'حفظ',onPressButton: (){},)
              ]
            ),
          ),
        ),
      ),
    );
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool hasImage=false;
  goTOGallery() async{
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
