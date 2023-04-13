import 'package:flutter/material.dart';
import '../backend/get_jobs_by_company_id.dart';
import '../consts/colors.dart';
import '../widgets/reusable_career_card.dart';

String typeSelected = '';
int selectedTypeIndex=0;
class JobsInCompanyPage extends StatefulWidget {
  const JobsInCompanyPage({Key? key, required this.id, required this.companyName}) : super(key: key);
  final int id;
  final String companyName;
  @override
  State<JobsInCompanyPage> createState() => _JobsInCompanyPageState();
}

class _JobsInCompanyPageState extends State<JobsInCompanyPage> {
  List jobsList = [];
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData(int comId) async {
    // ignore: prefer_typing_uninitialized_variables
    var p;
    p = await getJobsByCompanyId(comId, from, length);
    jobsList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          p = await getJobsByCompanyId(comId, from, length);
          jobsList.addAll(p);
          setState(() {
            isLoadMore = false;
          });
        });
      }
    });
    setState(() {
      isDataFetched = true;
    });
  }

  @override
  void initState() {
    fetchData(widget.id);
    super.initState();
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: Text(
          'وظائف شاغرة في ${widget.companyName}',
          style: const TextStyle(
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: isDataFetched
                ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: isLoadMore
                      ? jobsList.length + 1
                      : jobsList.length,
                  itemBuilder: (context, index) {
                    if (index >= jobsList.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var id = jobsList[index]['ID'] ?? '';
                      var title = jobsList[index]['post_title']??'';
                      var content = jobsList[index]['post_content']??'';
                      var postDate = jobsList[index]['post_date']??'';
                      var companyName ='', location = '', views = '';
                      var emailLink ='', whatsappLink = '', phoneNumber = '',applicationLink='';
                      for (int i = 0; i < jobsList[index]['Array'].length; i++) {
                        if (jobsList[index]['Array'][i]['meta_key'] == 'custom-company-name') {
                          companyName = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                        if (jobsList[index]['Array'][i]['meta_key'] == '_noo_views_count') {
                          views = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                        if (jobsList[index]['Array'][i]['meta_key'] == 'external-email') {
                          emailLink = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                        if (jobsList[index]['Array'][i]['meta_key'] == '_jm_company_field__whatsapp') {
                          whatsappLink = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                        if (jobsList[index]['Array'][i]['meta_key'] == '_jm_company_field__phone_number') {
                          phoneNumber = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                        if (jobsList[index]['Array'][i]['meta_key'] == 'external-application-link') {
                          applicationLink = jobsList[index]['Array'][i]['meta_value']??'';
                        }
                      }
                      for (int i = 0; i < jobsList[index]['tags'].length; i++) {
                        if (jobsList[index]['tags'][i]['taxonomy'] == 'job_location') {
                          location = jobsList[index]['tags'][i]['name']??'';
                        }
                      }
                      return ReusableCareerCard(
                        isWeInDetailsPage: false,
                        id: id,
                        title: title,
                        date:postDate,
                        location: location,
                        views: views,
                        content: content,
                        company: companyName==''?'wzifaa':companyName,
                        emailLink :emailLink,
                        whatsappLink :whatsappLink,
                        phoneNumber:phoneNumber,
                        applicationLink:applicationLink,
                        logo: '',
                      );
                    }
                  }),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

