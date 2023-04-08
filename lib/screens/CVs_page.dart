import 'package:flutter/material.dart';
import 'package:wazefaa/consts/colors.dart';

import '../backend/get_users(cv).dart';
import '../widgets/reusable_CV_card.dart';

class CVsPage extends StatefulWidget {
  const CVsPage({Key? key}) : super(key: key);

  @override
  State<CVsPage> createState() => _CVsPageState();
}

class _CVsPageState extends State<CVsPage> {
  List cvsList = [];
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p = await getUsers('', from, length);
    cvsList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          p = await getUsers('', from, length);
          cvsList.addAll(p);
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
          'السير الذاتية',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
                    itemCount: isLoadMore ? cvsList.length + 1 : cvsList.length,
                    itemBuilder: (context, index) {
                      if (index >= cvsList.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var id = '', title = '';
                        id = cvsList[index]['ID'];
                        title = cvsList[index]['post_title'];
                        String date=cvsList[index]['post'][0]['post_date']??'';
                        var userName = '';
                        var location = '', review = '';
                        for (int i = 0; i < cvsList[index]['usermeta'].length; i++) {
                          if (cvsList[index]['usermeta'][i]['meta_user_key'] == 'nickname') {
                            userName = cvsList[index]['usermeta'][i]['meta_user_value'];
                          }
                        }
                        for (int i = 0; i < cvsList[index]['postmeta'].length; i++) {
                          if (cvsList[index]['postmeta'][i]['meta_key'] == '_job_location') {
                            location = cvsList[index]['postmeta'][i]['meta_value'];}
                          if (cvsList[index]['postmeta'][i]['meta_key'] == '"_noo_views_count') {
                            review =
                                cvsList[index]['postmeta'][i]['meta_value'];
                          }
                        }

                        return ReusableCvCard(
                          id: id,
                          title: title,
                          date:date,
                          userName: userName,
                          location: location,
                          review: review,
                          image: '',
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
