import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../widgets/Reusable_post_card_in_blog.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List postsList = [
    {
      'image': 'assets/images/blog.jpg',
      'text':
          'ثقافة العمل داخل المملكة العربية السعودية  العمل داخل المملكة العربية السعودية مفهوم ثقافة العمل هي مجموعة من المواقف والمعتقدات والأفكار والقواعد والتوقعات والسلوكيات ',
      'title': 'نصائح للعثور على وظيفة في المملكة العربية السعودية',
      'short_title': 'وظيفة كوم',
      'date': '22 فبراير 2023',
      'comments_count': '5',
      'jop': 'وظائف شلغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
          'وظائف شلغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
          'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'image': 'assets/images/blog.jpg',
      'text':
          'ثقافة العمل داخل المملكة العربية السعودية  العمل داخل المملكة العربية السعودية مفهوم ثقافة العمل هي مجموعة من المواقف والمعتقدات والأفكار والقواعد والتوقعات والسلوكيات ',
      'title': 'نصائح للعثور على وظيفة في المملكة العربية السعودية',
      'short_title': 'وظيفة كوم',
      'date': '22 فبراير 2023',
      'comments_count': '5',
      'jop': 'وظائف شلغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
          'وظائف شلغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
          'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'image': 'assets/images/blog.jpg',
      'text':
          'ثقافة العمل داخل المملكة العربية السعودية  العمل داخل المملكة العربية السعودية مفهوم ثقافة العمل هي مجموعة من المواقف والمعتقدات والأفكار والقواعد والتوقعات والسلوكيات ',
      'title': 'نصائح للعثور على وظيفة في المملكة العربية السعودية',
      'short_title': 'وظيفة كوم',
      'date': '22 فبراير 2023',
      'comments_count': '5',
      'jop': 'وظائف شلغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
          'وظائف شلغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
          'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'المدونة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            color: kBgColor,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (context, index) => ReusablePostCard(
                infoMap: postsList[index],
              ),
            )),
      ),
    );
  }
}
