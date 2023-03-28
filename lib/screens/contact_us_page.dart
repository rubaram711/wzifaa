import 'package:flutter/material.dart';
import '../consts/colors.dart';
import '../consts/social_media_information.dart';
import '../widgets/logo.dart';
import '../widgets/reusable_back_arrow.dart';
import '../widgets/reusable_social_media_card.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBgColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  reusableBackArrow(() {
                    Navigator.pop(context);
                  }),
                ],
              ),
              Expanded(
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LogoWithBlueName(),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'تواصل معنا',
                      style: TextStyle(
                          color: kBasicColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          'وظائف اليوم بتدور على شغل بجد؟ وظيفة كوم هي طريقك لتبحث عن وظائف شاغرة في الوطن العربي واوروبا. فرص عمل مهما كانت مؤهلاتك, خبراتك, او مهاراتك . فرص عمل ,وظائف شاغرة,البحث عن عمل, البحث عن وظيفة, شركات التوظيف ومواقع التوظيف ',
                          style: TextStyle(
                              color: kBasicColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'عن طريق حسابات التواصل الاجتماعي التالية:',
                      style: TextStyle(
                          color: kThirdColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      primary: false,
                      itemCount: socialMediaInfoList.length,
                      itemBuilder: (context, index) => ReusableSocialMediaCard(
                          infoMap: socialMediaInfoList[index]),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
