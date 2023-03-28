import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../widgets/reusable_company_card.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  List companiesList=[
    {
      'logo':'assets/images/logo_circle.png',
      'company_name':'BMW of North America',
      'availability':'0',
      'rating':2,
      'review':'22',
      'jop': 'وظائف شاغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
      'وظائف شاغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
      'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'logo':'assets/images/logo_circle.png',
      'company_name':'BMW of North America',
      'availability':'0',
      'rating':3,
      'review':'22',
      'jop': 'وظائف شاغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
      'وظائف شاغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
      'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'logo':'assets/images/logo_circle.png',
      'company_name':'BMW of North America',
      'availability':'0',
      'rating':2,
      'review':'22',
      'jop': 'وظائف شاغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
      'وظائف شاغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
      'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'logo':'assets/images/logo_circle.png',
      'company_name':'BMW of North America',
      'availability':'0',
      'rating':2,
      'review':'22',
      'jop': 'وظائف شاغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
      'وظائف شاغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
      'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    },
    {
      'logo':'assets/images/logo_circle.png',
      'company_name':'BMW of North America',
      'availability':'0',
      'rating':2,
      'review':'22',
      'jop': 'وظائف شاغرة مطلوب معلمين مرحلة الثانية لدى مدرسة شيربورن للبنات',
      'description':
      'وظائف شاغرة في قطر لدى مدرسة شيربورن قطر للبنات برواتب عالية ومزايا قوية',
      'Qualification':
      'يجب أن يكون المتقدم للوظيفة حاصل على مؤهل تعليمي معتمد على المملكة المتحدة مثل B.Ed او PGCE او ما يعادلها'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight:MediaQuery.of(context).size.height*0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'الشركات',
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
          margin:const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.fromLTRB(15,10,15,0),
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: companiesList.length,
              itemBuilder: (context, index) => ReusableCompanyCard(
                infoMap: companiesList[index],isWeInDetailsPage: false,
              ),
            )),
      ),
    );
  }
}
