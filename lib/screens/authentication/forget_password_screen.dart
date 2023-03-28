import 'package:flutter/material.dart';
import 'package:wazefaa/screens/authentication/validation_function.dart';
import '../../backend/reset_password.dart';
import '../../consts/colors.dart';
import '../../widgets/logo.dart';
import '../../widgets/reusable_alert.dart';
import '../../widgets/reusable_button.dart';
import '../../widgets/reusable_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email='';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  const LogoWithBlueName(),
                  const SizedBox(height: 40),
                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.8,
                     child: const Text(
                       'أدخل البريد الالكتروني الخاص بك وسوف نرسل لك رابط لتغيير كلمة المرور',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: kBasicColor,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                  const SizedBox(height: 40),
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
                  const SizedBox(height: 40),
                  ReUsableButton(text: 'استعادة كلمة المرور', onPressButton: () async{
                    if (_formKey.currentState!.validate()) {
                      var response = await resetPassword(_email);
                      if(response==200){
                        Navigator.pushNamed(context, '/home');
                      }
                      else{
                        alert(context, 'يوجد خطأ ما تحقق من معلوماتك');
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
