import 'package:flutter/material.dart';
import '../backend/get_companies.dart';
import '../consts/colors.dart';
import '../widgets/reusable_company_card.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  List companiesList = [];
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p = await getAllCompanies(from, length);
    companiesList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          p = await getAllCompanies(from, length);
          companiesList.addAll(p);
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
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
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
      body: isDataFetched
          ? Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: isLoadMore
                      ? companiesList.length + 1
                      : companiesList.length,
                  itemBuilder: (context, index) {
                    if (index >= companiesList.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var id = companiesList[index]['ID']??'';
                      var title = companiesList[index]['post_title']??'';
                      var date = companiesList[index]['post_date']??'';
                      var content = companiesList[index]['post_content']??'';
                      var jobsCount = '', rating = '', review = '';
                      for (int i = 0; i < companiesList[index]['tags'].length; i++) {
                        if (companiesList[index]['tags'][i]['meta_key'] ==
                            '_noo_job_count') {
                          jobsCount =
                              companiesList[index]['tags'][i]['meta_value']??'';
                        }
                        if (companiesList[index]['tags'][i]['meta_key'] ==
                            '_noo_average_rating') {
                          rating =
                              companiesList[index]['tags'][i]['meta_value']??'';
                        }
                        if (companiesList[index]['tags'][i]['meta_key'] ==
                            'total_review') {
                          review =
                              companiesList[index]['tags'][i]['meta_value']??'';
                        }
                      }
                      return ReusableCompanyCard(
                        isWeInDetailsPage: false,
                        id: id,
                        title: title,
                        date:date,
                        jobsCount: jobsCount,
                        rating: rating.substring(0,1),
                        review: review,
                        content: content,
                        logo: 'assets/images/logo_circle.png',
                      );
                    }
                  }),
            ),
          )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
