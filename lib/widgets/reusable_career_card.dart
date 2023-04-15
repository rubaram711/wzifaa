import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';
import 'package:wazefaa/widgets/reusable_review_row.dart';
import 'package:wazefaa/widgets/reusable_save_button.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';
import 'package:share_plus/share_plus.dart';

import '../backend/save_favorite_locally.dart';

class ReusableCareerCard extends StatelessWidget {
  const ReusableCareerCard({
    Key? key,
    required this.isWeInDetailsPage,
    required this.id,
    required this.title,
    required this.location,
    required this.views,
    required this.content,
    required this.logo,
    required this.company, required this.date, required this.emailLink, required this.whatsappLink, required this.phoneNumber, required this.applicationLink,
  }) : super(key: key);
  final bool isWeInDetailsPage;
  final String id;
  final String title;
  final String date;
  final String company;
  final String location;
  final String views;
  final String content;
  final String logo;
  final String emailLink;
  final String whatsappLink;
  final String phoneNumber;
  final String applicationLink;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ReusableSaveButton(onPress: ()async{
                await addJobToSP({
                  'id': id,
                  'title': title,
                  'date':date,
                  'company': company,
                  'location': location,
                  'views': views,
                  'content': content,
                  'emailLink' :emailLink,
                  'whatsappLink' :whatsappLink,
                  'phoneNumber' :phoneNumber,
                  'applicationLink':applicationLink,
                  'logo': logo
                });
                alert(context, 'تم حفظ الوظيفة الى المفضلة');
              }),
              const SizedBox(
                width: 20,
              ),
              ReusableShareButton(shareFunction: (){
                Share.share('https://wzifaa.com/jobs/?page_id=$id') ;
              }),
            ],
          ),
          InkWell(
            onTap: () {
              isWeInDetailsPage
                  ? null
                  : Navigator.pushNamed(context, '/career_details', arguments: {
                'id': id,
                'title': title,
                'date':date,
                'company': company,
                'location': location,
                'views': views,
                'content': content.replaceAll('\r\n', '<br>'),
                'emailLink' :emailLink,
                'whatsappLink' :whatsappLink,
                'phoneNumber' :phoneNumber,
                'applicationLink':applicationLink,
                'logo': logo
              });
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logo==''
                        ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Image.asset('assets/images/search_wazifa_logo.png'))
                        :CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Image.asset(logo)),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: kThirdColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        isWeInDetailsPage
                            ? const SizedBox()
                            :  Row(children: [
                          Icon(Icons.calendar_month,size: 17,color: Colors.grey[700],),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(date.substring(0,10))
                        ],),
                        const SizedBox(
                          height: 7,
                        ),
                        // isWeInDetailsPage
                        //     ? const SizedBox()
                        //     : const Text('وظائف شاغرة'),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        Row(
                          children: [
                            Icon(
                              Icons.push_pin,
                              size: 17,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(location,)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                isWeInDetailsPage
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: kSecondaryColor)),
                            child: Center(
                              child: Text(
                                company,
                                style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ReusableReviewRow(
                            review: views,
                          ),
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
