import 'package:flutter/material.dart';

import '../../backend/save_favorite_locally.dart';
import '../../widgets/reusable_career_card.dart';
class FavoriteJobs extends StatefulWidget {
  const FavoriteJobs({Key? key}) : super(key: key);

  @override
  State<FavoriteJobs> createState() => _FavoriteJobsState();
}

class _FavoriteJobsState extends State<FavoriteJobs> {
  List<Map<String, dynamic>> favJobsList = [];
  bool isDataFetched=false;
  getFavoriteCompanies() async{
    favJobsList  = await getJobsFromSP() ?? [];
    setState(() {
      isDataFetched=true;
    });
  }
  @override
  void initState() {
    getFavoriteCompanies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isDataFetched
        ? Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: favJobsList.length,
            itemBuilder: (context, index) {
              return ReusableCareerCard(
                isWeInDetailsPage: false,
                id: favJobsList[index]['id']??'',
                title: favJobsList[index]['title']??'',
                date:favJobsList[index]['date']??'',
                company: favJobsList[index]['company']??'',
                location: favJobsList[index]['location']??'',
                views: favJobsList[index]['views']??'',
                content: favJobsList[index]['content']??'',
                logo: favJobsList[index]['logo']??'',
              );
            }),
      ),
    )
        : const Center(
      child: CircularProgressIndicator(),
    );
  }
}