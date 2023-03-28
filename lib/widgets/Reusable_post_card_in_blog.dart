import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';


class ReusablePostCard extends StatelessWidget {
  const ReusablePostCard({
    Key? key,
    required this.infoMap,
  }) : super(key: key);
  final Map infoMap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              infoMap['title'],
              style: const TextStyle(color: kThirdColor, fontSize: 15,fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(children: [
                Icon(Icons.edit,size: 17,color: Colors.grey[700],),
                const SizedBox(
                  width: 5,
                ),
                Text(infoMap['short_title'])
              ],),
              Row(children: [
                Icon(Icons.calendar_month,size: 17,color: Colors.grey[700],),
                const SizedBox(
                  width: 5,
                ),
                Text(infoMap['date'])
              ],)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.23,
            width: MediaQuery.of(context).size.width*0.83,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(infoMap['image'],fit: BoxFit.cover,)),
          ),
         // Image.asset(infoMap['image'],height: MediaQuery.of(context).size.height*0.3,),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Text(infoMap['text'])),
          const SizedBox(
            height: 5,
          ),
          Divider(color: Colors.grey.withOpacity(0.5),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10,),
                  const Icon(
                    Icons.comment,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '${infoMap['comments_count']} تعليقات ',
                    style: TextStyle(color: Colors.grey[700],fontSize: 15),),
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/blog_details',arguments: infoMap);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                  decoration: BoxDecoration(
                      color: kThirdColor,
                      borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('أكمل القراءة',style:TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.bold),),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
