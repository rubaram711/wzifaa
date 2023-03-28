import 'package:flutter/material.dart';
import 'package:wazefaa/backend/add_job.dart';
import 'package:wazefaa/screens/authentication/validation_function.dart';
import '../../consts/colors.dart';
import '../../widgets/logo.dart';
import '../../widgets/reusable_back_arrow.dart';
import '../../widgets/reusable_button.dart';
import '../../widgets/reusable_text_field.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _title = '';
  String _exp = '', _content = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                    reusableBackArrow(() {
                      Navigator.pop(context);
                    }),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const LogoWithBlueName(),
                      const SizedBox(
                        height: 40,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'إضافة وظيفة',
                          style: TextStyle(
                            color: kBasicColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ReusableTextField(
                        text: 'المسمى الوظيفي',
                        isPasswordField: false,
                        onChangedFunc: (value) {
                          _formKey.currentState?.validate();
                          setState(() {
                            _title = value;
                          });
                        },
                        validationFunc: (value) {
                          if (value.isEmpty) {
                            return 'please fill this field';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableTextField(
                        text: 'تفاصيل الوظيفة',
                        isPasswordField: false,
                        onChangedFunc: (value) {
                          _formKey.currentState?.validate();
                          setState(() {
                            _content = value;
                          });
                        },
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'please fill this field';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                          if (isNotCorrectEmail(value)) {
                            return 'please check your email format';
                          }
                        },
                      ),
                      const SizedBox(height: 20,),
                      ReusableTextField(
                        text: 'تاريخ انتهاء عرض الوظيفة',
                        isPasswordField: false,
                        onChangedFunc: (value) {
                          _formKey.currentState?.validate();
                          setState(() {
                            _exp = value;
                          });
                        },
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'please fill this field';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ReUsableButton(
                        text: 'إكمال تعبئة البيانات',
                        onPressButton: () async {
                          if (_formKey.currentState!.validate()) {
                            //todo get author
                            var response = await addJob(
                                'user_id', _title, _email, _content, _exp);
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
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
