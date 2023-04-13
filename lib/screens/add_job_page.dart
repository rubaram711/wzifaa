import 'package:flutter/material.dart';
import 'package:wazefaa/backend/add_job.dart';
import 'package:wazefaa/screens/authentication/validation_function.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';
import '../../consts/colors.dart';
import '../../widgets/logo.dart';
import '../../widgets/reusable_back_arrow.dart';
import '../../widgets/reusable_button.dart';
import '../../widgets/reusable_text_field.dart';
import '../backend/save_user_info_locally.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authentication/login_screen.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _title = '';
  String _exp = '', _yearExp = '', _monthExp = 'الشهر', _dayExp = '', _content = '';
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
                        isEnabled: true,
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
                        isEnabled: true,
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
                        isEnabled: true,
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('تاريخ انتهاء عرض الوظيفة'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.27,
                            //margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                            child: ReusableTextField(
                              text: 'اليوم',
                              isPasswordField: false,
                              isEnabled: true,
                              onChangedFunc: (value) {
                                _formKey.currentState?.validate();
                                setState(() {
                                  _dayExp = value;
                                });
                              },
                              validationFunc: (String value) {
                                if (value.isEmpty) {
                                  return 'please fill this field';
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      _buildMonthsSheet(context));
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.27,
                              // margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                              child: ReusableTextField(
                                text: _monthExp,//'الشهر',
                                isPasswordField: false,
                                isEnabled: false,
                                onChangedFunc: (value) {
                                  _formKey.currentState?.validate();
                                  setState(() {
                                    _monthExp = value;
                                  });
                                },
                                validationFunc: (String value) {
                                  if (_monthExp=='الشهر') {
                                    return 'please fill this field';
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.27,
                            // margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                            child: ReusableTextField(
                              text: 'السنة',
                              isPasswordField: false,
                              isEnabled: true,
                              onChangedFunc: (value) {
                                _formKey.currentState?.validate();
                                setState(() {
                                  _yearExp = value;
                                });
                              },
                              validationFunc: (String value) {
                                if (value.isEmpty) {
                                  return 'please fill this field';
                                }
                              },
                            ),
                          ),
                        ],
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
                           if(_monthExp=='الشهر'){
                             alert(context, 'there is an error,please choose a month');
                           }
                           else if (_formKey.currentState!.validate()) {
                            _exp = '$_dayExp $_monthExp $_yearExp';
                            String author = await getIdFromPref();
                            if(author==''){
                              // ignore: use_build_context_synchronously
                              alert(context, 'حدث خطأ, عليك إعادة تسجيل الدخول');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                      (Route<dynamic> route) => false);
                            }
                            else{
                            var response = await addJob(
                                author, _title, _email, _content, _exp);
                            if(response=={"msg": "Access denied"}){
                              // ignore: use_build_context_synchronously
                              alert(context, 'حدث خطأ, عليك إعادة تسجيل الدخول');
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                      (Route<dynamic> route) => false);
                            }
                            else{
                              int jobId=response['job_id'];
                              var kRedirectEditJobUrl = "https://wzifaa.com/wp-json/v1/jobs/redirect/?job_id=$jobId";
                              if (await canLaunchUrl(Uri.parse(kRedirectEditJobUrl))) {
                                await launchUrl( Uri.parse(kRedirectEditJobUrl), mode: LaunchMode.externalApplication );
                              } else { throw 'There was a problem to open the url: $kRedirectEditJobUrl'; }
                            }
                          }}
                        }
                        ),
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
  List months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  SizedBox _buildMonthsSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      //padding: const EdgeInsets.all(10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              color: kBasicColor,
              child: const Center(
                child: Text('اختر أحد الأشهر',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                height: MediaQuery.of(context).size.height*0.38,
              child: ListView.builder(
                  itemCount:months.length ,
                  itemBuilder: (context, index) =>Container(
                      padding:const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _monthExp=months[index];
                            Navigator.pop(context);
                          });
                        },
                        child: Text(months[index],
                        style: const TextStyle(fontSize: 18),
                        ),
                      ),
                  ) )
            )
          ],
        ),
      ),
    );
  }
}

