import 'package:flutter/material.dart';
import '../../backend/save_favorite_locally.dart';
import '../../widgets/reusable_company_card.dart';

class FavoriteCompanies extends StatefulWidget {
  const FavoriteCompanies({Key? key}) : super(key: key);

  @override
  State<FavoriteCompanies> createState() => _FavoriteCompaniesState();
}

class _FavoriteCompaniesState extends State<FavoriteCompanies> {
  List<Map<String, dynamic>> favCompaniesList = [];
  bool isDataFetched=false;
  getFavoriteCompanies() async{
    favCompaniesList  = await getCompaniesFromSP() ?? [];
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
                  itemCount: favCompaniesList.length,
                  itemBuilder: (context, index) {
                    return ReusableCompanyCard(
                      isWeInDetailsPage: false,
                      id: favCompaniesList[index]['id'],
                      title: favCompaniesList[index]['title'],
                      date:favCompaniesList[index]['date'],
                      jobsCount: favCompaniesList[index]['jobsCount'],
                      rating: favCompaniesList[index]['rating'],
                      review: favCompaniesList[index]['review'],
                      content: favCompaniesList[index]['content'],
                      logo: 'assets/images/logo_circle.png',
                    );
                  }),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
