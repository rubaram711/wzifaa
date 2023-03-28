
import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';
import 'package:wazefaa/widgets/reusable_review_row.dart';
import 'package:wazefaa/widgets/reusable_share_button.dart';

class ReusableCvCard extends StatelessWidget {
  const ReusableCvCard({
    Key? key,
    required this.infoMap,
  }) : super(key: key);
  final Map infoMap;
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
            children: const [
              ReusableShareButton(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoMap['image']!=null
                  ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 32,
                  child:ClipOval(
                      child: Image.asset(infoMap['image'],fit: BoxFit.cover,height: 64,width: 64,)
                  ),)
              :const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 32,
                  child: Icon(Icons.person,color: Colors.black,size: 30,)),
              const SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      infoMap['name'],
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
                    Text(infoMap['jop']),
                  ],),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(children: [
                    Icon(Icons.location_on,size: 17,color: Colors.grey[700],),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(infoMap['location']),
                  ],),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableReviewRow(review: '${infoMap['review']}',),
              IconButton(icon:const Icon(Icons.favorite_border,size: 17,),onPressed: (){},)
            ],
          )
        ],
      ),
    );
  }
}
