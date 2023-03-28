import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_review_row.dart';
import 'package:wazefaa/widgets/reusable_save_button.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';

class ReusableCareerCard extends StatelessWidget {
  const ReusableCareerCard({
    Key? key,
    required this.infoMap, required this.isWeInDetailsPage,
  }) : super(key: key);
  final Map infoMap;
  final bool isWeInDetailsPage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isWeInDetailsPage ? null: Navigator.pushNamed(context, '/career_details',arguments: infoMap);
      },
      child: Container(
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
              children: const [
                ReusableSaveButton(),
                SizedBox(
                  width: 20,
                ),
                ReusableShareButton(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child: Image.asset(infoMap['logo'])),
                const SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        infoMap['description'],
                        style: const TextStyle(color: kThirdColor, fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    isWeInDetailsPage
                        ?const SizedBox()
                        : const Text('وظائف شاغرة'),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(children: [
                      Icon(Icons.push_pin,size: 17,color: Colors.grey[700],),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(infoMap['country'])
                    ],)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            isWeInDetailsPage
                ?const SizedBox()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kSecondaryColor)
                  ),
                  child: Center(child: Text(infoMap['company'],style:const TextStyle(color: kSecondaryColor,fontWeight: FontWeight.bold),),),
                ),
                ReusableReviewRow(review: '${infoMap['views']}',),
              ],
            )
          ],
        ),
      ),
    );
  }
}
