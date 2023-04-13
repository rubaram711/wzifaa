import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wazefaa/widgets/reusable_button.dart';
import 'package:wazefaa/widgets/reusable_company_card.dart';
import 'package:flutter_html/flutter_html.dart';
import '../consts/colors.dart';
import 'jobs_in_company_page.dart';

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'تفاصيل الشركة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableCompanyCard(
                        id: args!['id'],
                        title: args['title'],
                        date: args['date'],
                        content: args['content'],
                        rating: args['rating'],
                        review: args['review'],
                        jobsCount: args['jobsCount'],
                        logo: args['logo'],
                        isWeInDetailsPage: true),
                    args['jobsCount']!= '0'?  ReUsableButton(
                        text: 'رؤية الوظائف الشاغرة',
                        onPressButton: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobsInCompanyPage(
                                      id: int.parse(args['id']),
                                      companyName: args['title'],
                                    )),
                          );
                        }):const SizedBox(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Html(
                        data: args['content'],
                        onLinkTap: (url, _, __, ___) async {
                          if (await canLaunchUrl(Uri.parse(url!))) {
                            await launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
