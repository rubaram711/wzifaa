import 'package:flutter/material.dart';
import 'package:wazefaa/screens/authentication/validation_function.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';

import '../../backend/register.dart';
import '../../consts/colors.dart';
import '../../widgets/logo.dart';
import '../../widgets/reusable_back_arrow.dart';
import '../../widgets/reusable_button.dart';
import '../../widgets/reusable_text_field.dart';
import '../../widgets/reusable_textfield_with_sheet.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email='',_username='';
  String _password='',_confirmPassword='';
  int _role=0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: kBgColor,
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    reusableBackArrow((){Navigator.pop(context);}),
                  ],
                ),
                Expanded(
                  child:
                    ListView(
                      children: [
                        const LogoWithBlueName(),
                        const SizedBox(height: 40,),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تسجيل جديد',
                            style: TextStyle(
                              color: kBasicColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        ReusableTextField(
                          text: 'الاسم',
                          isPasswordField: false,
                          onChangedFunc: (value) {
                            _formKey.currentState?.validate();
                            setState(() {
                              _username = value;
                            });
                          },
                          validationFunc: (value) {
                            if (value.isEmpty) {
                              return 'please fill this field';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        ReusableTextField(
                          text: 'البريد الإلكتروني',
                          isPasswordField: false,
                          onChangedFunc: (value) {
                            _formKey.currentState?.validate();
                            setState(() {
                              _email = value;
                            });
                          },
                          validationFunc: (value) {
                            if (value.isEmpty) {
                              return 'please fill this field';
                            }
                            if(isNotCorrectEmail(value)){
                              return 'please check your email format';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        ReusableTextFieldWithSheet(
                          text: 'الخيارات',
                          onChangedFunc: (value) {
                            _formKey.currentState?.validate();
                          },
                          validationFunc: (value) {
                            if (value.isEmpty) {
                              return 'please fill this field';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        ReusableTextField(
                          text: 'كلمة المرور',
                          isPasswordField: true,
                          onChangedFunc: (value) {
                            _formKey.currentState?.validate();
                            setState(() {
                              _password = value;
                            });
                          },
                          validationFunc: (String value) {
                            if (value.isEmpty) {
                              return 'please fill this field';
                            }
                            if (value.length < 6 ||
                                !value.contains(RegExp(r'[A-Za-z]')) ||
                                !value.contains(RegExp(r'[0-9]'))) {
                              return 'Enter at least 6 characters containing numbers and letters';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        ReusableTextField(
                          text: 'أعد إدخال كلمة المرور',
                          isPasswordField: true,
                          onChangedFunc: (value) {
                            _formKey.currentState?.validate();
                            setState(() {
                              _confirmPassword = value;
                            });
                          },
                          validationFunc: (String value) {
                            if (value.isEmpty) {
                              return 'please fill this field';
                            }
                            if (value!=_password) {
                              return 'please enter a matching password';
                            }
                          },
                        ),
                      ],
                    ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    ReUsableButton(text: 'تسجيل', onPressButton: () async{
                      if (_formKey.currentState!.validate()) {
                        if ( option=='أنا شخص أبحث عن عمل'){
                          setState(() {
                            _role=1;
                          });
                        }
                            var response = await register(
                                _username, _email, _password, _role);
                            if(response=='Success'){
                              Navigator.pushNamed(context, '/home');
                            }
                            else{
                              alert(context, 'الحساب موجود مسبقاً قم بتسجيل الدخول');
                            }
                          }
                        }
                        ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('لديك حساب بالفعل؟'),
                        ReUsableTextButton(
                          text: 'تسجيل الدخول',
                          onPress: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          isGrey: false,
                          isUnderLined: false,
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
