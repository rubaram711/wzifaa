import 'package:flutter/material.dart';
import 'package:wazefaa/consts/countries_list.dart';
import '../consts/colors.dart';
import '../widgets/logo.dart';
import '../widgets/reusable_career_card.dart';

class CarrerasByCountryPage extends StatefulWidget {
  const CarrerasByCountryPage({Key? key}) : super(key: key);

  @override
  State<CarrerasByCountryPage> createState() => _CarrerasByCountryPageState();
}

class _CarrerasByCountryPageState extends State<CarrerasByCountryPage> {
  List carrerasByCountryList = [
    {
      'logo': 'assets/images/logo_circle.png',
      'description': 'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country': 'الإمارات العربية المتحدة',
      'company': 'HDL Express شركة',
      'views': '22',
      'location': 'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name': 'مهندس مبيعات',
      'Qualification': [
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
      'logo': 'assets/images/logo_circle.png',
      'description': 'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country': 'الإمارات العربية المتحدة',
      'company': 'HDL Express شركة',
      'views': '22',
      'location': 'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name': 'مهندس مبيعات',
      'Qualification': [
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
      'logo': 'assets/images/logo_circle.png',
      'description': 'وظائف شاغرة في أبو ظبي لكافة الجنسيات برواتب مجزية',
      'country': 'الإمارات العربية المتحدة',
      'company': 'HDL Express شركة',
      'views': '22',
      'location': 'وظائف اليوم في السعودية لدى Atlas Copco في جدة 16/2/2023 ',
      'jop_name': 'مهندس مبيعات',
      'Qualification': [
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

  String countrySelected =  '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.14,
        backgroundColor: kBasicColor,
        title: const Logo(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) =>
                                _buildBottomSheetForCountries(context));
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.filter_alt,
                            color: kThirdColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'وظائف حسب الدولة',
                            style: TextStyle(
                                color: kThirdColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView.builder(
                      itemCount: carrerasByCountryList.length,
                      itemBuilder: (context, index) => ReusableCareerCard(
                        infoMap: carrerasByCountryList[index],
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

  SizedBox _buildBottomSheetForCountries(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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
                  'اختر دولة',
                  style: TextStyle(
                      color: kThirdColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15,15 ,15,0),
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemCount: countriesList.length,
                itemBuilder: (context, index) => Material(
                  child: RadioListTile(
                    title: Text(
                      countriesList[index],
                      style: const TextStyle(
                          fontSize: 14,
                          color: kThirdColor,
                          fontWeight: FontWeight.bold),
                    ),
                    value: countriesList[index],
                    groupValue: countrySelected,
                    onChanged: (value) {
                      setState(() {
                        countrySelected = value;
                        print(countrySelected);
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
