import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';
import 'package:wazefaa/widgets/reusable_review_row.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';
import 'package:share_plus/share_plus.dart';

import '../backend/save_favorite_locally.dart';
class ReusableCvCard extends StatelessWidget {
  const ReusableCvCard({
    Key? key, required this.id, required this.title, required this.userName, required this.location, required this.review, required this.image, required this.date,

  }) : super(key: key);
 final String id;
  final String title;
  final String userName;
  final String location;
  final String review;
  final String image;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.fromLTRB(10,10,10,0),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ReusableShareButton(shareFunction: (){
                Share.share('https://wzifaa.com/candidates-cv/?page_id=$id') ;
              }),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: ()async{
              // await launchUrl(Uri.parse(infoMap['link']),);
              if (await canLaunchUrl(Uri.parse('https://wzifaa.com/candidates-cv/?page_id=$id'))) {
                await launchUrl( Uri.parse('https://wzifaa.com/candidates-cv/?page_id=$id'),mode: LaunchMode.externalApplication );
              } else { throw 'There was a problem to open the url: https://wzifaa.com/candidates-cv/?page_id=$id'; }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image !=''
                    ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child:ClipOval(
                        child: Image.asset(image,fit: BoxFit.cover,height: 64,width: 64,)
                    ),)
                : CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child:  Image.asset('assets/images/user_icon.png')),
                const SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        userName,
                        style: const TextStyle(color: kThirdColor, fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(children: [
                      Icon(Icons.cases_rounded,size: 17,color: Colors.grey[700],),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.55,
                          child: Text(title)),
                    ],),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(children: [
                      Icon(Icons.location_on,size: 17,color: Colors.grey[700],),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(location),
                    ],),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(children: [
                      Icon(Icons.calendar_month,size: 17,color: Colors.grey[700],),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(date.substring(0,10))
                    ],)
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableReviewRow(review: review,),
              IconButton(icon:const Icon(Icons.favorite_border,size: 17,),onPressed: ()async{
                await addCVToSP({
                  'id': id,
                  'title': title,
                  'date': date,
                  'userName': userName,
                  'location': location,
                  'review': review,
                  'image': image,
                });
                alert(context, 'تم الحفظ الى المفضلة');
              },)
            ],
          )
        ],
      ),
    );
  }
}
