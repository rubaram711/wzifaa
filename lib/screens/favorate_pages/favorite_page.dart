import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import 'favorite _CVs.dart';
import 'favorite_companies.dart';
import 'favorite_jobs.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {



  @override
  Widget build(BuildContext context) {
    final kTabPages = <Widget>[
      const FavoriteCompanies(),
      const FavoriteJobs(),
      const FavoriteCVs(),
    ];
    final kTabs = <Tab>[
      const Tab( text: 'الشركات'),
      const Tab(text: 'الوظائف'),
      const Tab(text: 'السير الذاتية'),
    ];
    return DefaultTabController(
      length: kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.10,
          backgroundColor: kBasicColor,
          title: const Text(
            'المفضلة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            tabs: kTabs,
          ),
        ),
        body: TabBarView(
          children: kTabPages,
        ),
      ),
    );
  }
}






