import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../consts/colors.dart';

class ReusableSocialMediaCard extends StatelessWidget {
  const ReusableSocialMediaCard({Key? key, required this.infoMap}) : super(key: key);
  final Map infoMap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
       // await launchUrl(Uri.parse(infoMap['link']),);
        if (await canLaunchUrl(Uri.parse(infoMap['link']))) {
          await launchUrl(Uri.parse(infoMap['link']),mode: LaunchMode.externalApplication );
        } else { throw 'There was a problem to open the url: ${infoMap['link']}'; }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kBgColor,
              radius: 20,
              child: ClipOval(
                  child: Image.asset(infoMap['logo'],fit: BoxFit.cover,height: 40,width: 40,)
              ),
            ),
           const SizedBox(width: 10,),
            Text(infoMap['name'],style: const TextStyle(
                color: kBasicColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
