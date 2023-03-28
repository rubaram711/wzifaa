import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../consts/jops_type_list.dart';
import '../widgets/reusable_career_card.dart';

class CarrerasPage extends StatefulWidget {
  const CarrerasPage({Key? key}) : super(key: key);

  @override
  State<CarrerasPage> createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage> {
  List carrerasList=[
    {
      'logo':'assets/images/logo_circle.png',
      'description':'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country':'الإمارات العربية المتحدة' ,
      'company':'HDL Express شركة',
      'views':'22',
      'location':'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name':'مهندس مبيعات',
      'Qualification':[
        'يجب ان يتقن اللغة الانكليزية(مستوى ممتاز)',
        'يجب ان يتقن العمل على الحاسوب ويتقن استخجام ادوات مايكروسوفت واوفيس',
        'يجب ان يتقن اللغة الانكليزية',
        'يفضل أن يجيد اللغة العربية',
        'يفضل أن يمتلك خلفية فنية وهندسية جيدة',
        'يفضل أن يكون حاصل على درجة هندسة ميكانيكية او ما يعادلها في المجال',
        'الإلمام والخبرة في التعامل والتفاوض بشأن الشروط والاحكام التجارية',
      ]
    },
    {
      'logo':'assets/images/logo_circle.png',
      'description':'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country':'الإمارات العربية المتحدة' ,
      'company':'HDL Express شركة',
      'views':'22',
      'location':'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name':'مهندس مبيعات',
      'Qualification':[
        'يجب ان يتقن اللغة الانكليزية(مستوى ممتاز)',
        'يجب ان يتقن العمل على الحاسوب ويتقن استخجام ادوات مايكروسوفت واوفيس',
        'يجب ان يتقن اللغة الانكليزية',
        'يفضل أن يجيد اللغة العربية',
        'يفضل أن يمتلك خلفية فنية وهندسية جيدة',
        'يفضل أن يكون حاصل على درجة هندسة ميكانيكية او ما يعادلها في المجال',
        'الإلمام والخبرة في التعامل والتفاوض بشأن الشروط والاحكام التجارية',
      ]
    },
    {
      'logo':'assets/images/logo_circle.png',
      'description':'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country':'الإمارات العربية المتحدة' ,
      'company':'HDL Express شركة',
      'views':'22',
      'location':'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name':'مهندس مبيعات',
      'Qualification':[
        'يجب ان يتقن اللغة الانكليزية(مستوى ممتاز)',
        'يجب ان يتقن العمل على الحاسوب ويتقن استخجام ادوات مايكروسوفت واوفيس',
        'يجب ان يتقن اللغة الانكليزية',
        'يفضل أن يجيد اللغة العربية',
        'يفضل أن يمتلك خلفية فنية وهندسية جيدة',
        'يفضل أن يكون حاصل على درجة هندسة ميكانيكية او ما يعادلها في المجال',
        'الإلمام والخبرة في التعامل والتفاوض بشأن الشروط والاحكام التجارية',
      ]
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
          'وظائف اليوم',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) =>
                                _buildBottomSheetForCarreras(context));
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.filter_alt,color: kThirdColor,),
                          SizedBox(width: 10,),
                          Text('أنواع الوظائف',style: TextStyle(color: kThirdColor, fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height*0.70,
                    child: ListView.builder(
                      itemCount: carrerasList.length,
                      itemBuilder: (context, index) => ReusableCareerCard(
                        infoMap: carrerasList[index],
                        isWeInDetailsPage: false,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

 String typeSelected='';
  SizedBox _buildBottomSheetForCarreras(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'اختر نوع الوظيفة',
                  style: TextStyle(
                      color: kThirdColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15,15 ,15,0),
              height: MediaQuery.of(context).size.height * 0.29,
              child: ListView.builder(
                itemCount: jobsTypeList.length,
                itemBuilder: (context, index) => Material(
                  child: RadioListTile(
                    title: Text(
                      jobsTypeList[index],
                      style: const TextStyle(
                          fontSize: 14,
                          color: kThirdColor,
                          fontWeight: FontWeight.bold),
                    ),
                    value: jobsTypeList[index],
                    groupValue: typeSelected,
                    onChanged: (value) {
                      setState(() {
                        typeSelected = value;
                        print(typeSelected);
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
