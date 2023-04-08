import 'package:flutter/material.dart';
import 'package:wazefaa/backend/save_favorite_locally.dart';

import '../../widgets/reusable_CV_card.dart';

class FavoriteCVs extends StatefulWidget {
  const FavoriteCVs({Key? key}) : super(key: key);

  @override
  State<FavoriteCVs> createState() => _FavoriteCVsState();
}

class _FavoriteCVsState extends State<FavoriteCVs> {
  List<Map<String, dynamic>> favCVsList = [];
  bool isDataFetched=false;
  getFavoriteCompanies() async{
    favCVsList  = await getCVsFromSP() ?? [];
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
            itemCount: favCVsList.length,
            itemBuilder: (context, index) {
              return ReusableCvCard(
                id: favCVsList[index]['id'],
                title: favCVsList[index]['title'],
                date:favCVsList[index]['date'],
                userName: favCVsList[index]['userName'],
                location: favCVsList[index]['location'],
                review: favCVsList[index]['review'],
                image: '',
              );
            }),
      ),
    )
        : const Center(
      child: CircularProgressIndicator(),
    );
  }
}
