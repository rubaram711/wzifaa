import 'package:flutter/material.dart';
import 'package:wazefaa/screens/authentication/validation_function.dart';

import '../../backend/login.dart';
import '../../consts/colors.dart';
import '../../widgets/logo.dart';
import '../../widgets/reusable_alert.dart';
import '../../widgets/reusable_button.dart';
import '../../widgets/reusable_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _email;
  var _password;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBgColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const LogoWithBlueName(),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: kBasicColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                      if (isNotCorrectPassword(value)) {
                        return 'Enter at least 6 characters containing numbers and letters';
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 16,
                      ),
                      ReUsableTextButton(
                        text: 'هل نسيت كلمة المرور؟',
                        onPress: () {
                          Navigator.pushNamed(context, '/forget_password');
                        },
                        isGrey: true,
                        isUnderLined: false,
                      ),
                    ],
                  ),
                  ReUsableTextButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    text: 'الدخول كزائر',
                    isGrey: false,
                    isUnderLined: true,
                  ),
                  ReUsableButton(text: 'تسجيل الدخول', onPressButton: () async{
                    if (_formKey.currentState!.validate()) {
                      var response = await login(_email, _password);
                      if(response=='Success'){
                        Navigator.pushNamed(context, '/home');
                      }
                      else{
                        alert(context, 'يوجد خطأ ما تحقق من معلوماتك');
                      }
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('ليس لديك حساب؟'),
                      ReUsableTextButton(
                        text: 'قم بالتسجيل الآن',
                        onPress: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        isGrey: false,
                        isUnderLined: false,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
