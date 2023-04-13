import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';
import '../consts/colors.dart';
//import '../widgets/reusable_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/reusable_button_for_get_job.dart';
import '../widgets/reusable_career_card.dart';

class CareerDetails extends StatelessWidget {
  const CareerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: Text(
          args!['company'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: ListView(
            children: [
              ReusableCareerCard(
                  id: args['id'],
                  title: args['title'],
                  date: args['date'],
                  content: args['content'],
                  company: args['company'],
                  location: args['location'],
                  views: args['views'],
                  logo: args['logo'],
                  emailLink :args['emailLink'],
                  whatsappLink :args['whatsappLink'],
                  phoneNumber:args['phoneNumber'],
                  applicationLink:args['applicationLink'],
                  isWeInDetailsPage: true),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                child: Html(
                  data: args['content'],
                  onLinkTap: (url, _, __, ___) async {
                    if (await canLaunchUrl(Uri.parse(url!))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              ),
              args['whatsappLink'].isNotEmpty?ReusableButtonForGetJob(
                text: 'التقديم من خلال واتس أب ',
                type: 'whatsapp',
                onPressFunc: ()async{
              var contact = args['whatsappLink'];
              String text='مرحباً بك في ${args['title']}';
              var androidUrl = "whatsapp://send?phone=$contact&text=$text";
              var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

              try{
              if(Platform.isIOS){
              await launchUrl(Uri.parse(iosUrl));
              }
              else{
              await launchUrl(Uri.parse(androidUrl));
              }
              } on Exception{
                alert(context, 'there is an error');
              }
              },
              ):const SizedBox(),
              args['emailLink'].isNotEmpty? ReusableButtonForGetJob(
                text: 'التقديم من خلال الإيميل ',
                type: 'email',
                onPressFunc: ()async{
                  String email = Uri.encodeComponent(args['emailLink']);
                  String subject = Uri.encodeComponent("مرحباً بك في ${args['title']}");
                  String body ='' ;
                  Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                  if (await canLaunchUrl(mail)) {
                    await launchUrl(mail,
                        mode: LaunchMode.externalApplication);
                  }
                },
              ):const SizedBox(),
              args['applicationLink'].isNotEmpty ?ReusableButtonForGetJob(
                text: 'التقديم من خلال موقع الويب',
                type: 'web',
                onPressFunc: ()async{
                  Uri uri = Uri.parse(args['applicationLink']);
                  if (await canLaunchUrl(uri)) {
                  await launchUrl(uri,
                  mode: LaunchMode.externalApplication);
                  }
                },
              ):const SizedBox(),
              args['phoneNumber'].isNotEmpty ?ReusableButtonForGetJob(
                text: 'التقديم من خلال رقم الهاتف',
                type: 'phone',
                onPressFunc: ()async{
                  Uri phone = Uri.parse('tel:${args['phoneNumber']}');
                  if (await canLaunchUrl(phone)) {
                    await launchUrl(phone,
                        mode: LaunchMode.externalApplication);
                  }
                },
              ):const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
