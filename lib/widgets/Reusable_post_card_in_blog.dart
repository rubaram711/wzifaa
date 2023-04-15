import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';


class ReusablePostCard extends StatelessWidget {
  const ReusablePostCard({
    Key? key, required this.id, required this.title, required this.authorName, required this.content, required this.image, required this.postDate,

  }) : super(key: key);
  final String id;
  final String title;
  final String authorName;
  final String content;
  final String image;
  final String postDate;
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
              title,
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
                Text(authorName)
              ],),
              Row(children: [
                Icon(Icons.calendar_month,size: 17,color: Colors.grey[700],),
                const SizedBox(
                  width: 5,
                ),
                 Text(postDate.substring(0,10))
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
                child: Image.asset(image ,fit: BoxFit.cover,)),
          ),
         // Image.asset(infoMap['image'],height: MediaQuery.of(context).size.height*0.3,),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child:Text(removeAllHtmlTags(content).substring(0,250))
              //Html(data:content.substring(0,200) ,)
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(color: Colors.grey.withOpacity(0.5),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/blog_details',arguments: {
                    'id': id,
                    'title': title,
                    'authorName': authorName,
                    'content': content.replaceAll('\r\n', '<br>'),
                  });
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


String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r'<[^>]*>|&[^;]+;',
      multiLine: true,
      caseSensitive: true
  );

  return htmlText.replaceAll(exp, '');
}