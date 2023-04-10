import 'package:flutter/material.dart';
import 'package:wazefaa/screens/blog_page.dart';
import 'package:wazefaa/screens/companies_page.dart';
import 'package:wazefaa/screens/carreras_page.dart';
import 'package:wazefaa/screens/more_page.dart';
import '../consts/colors.dart';
import 'carreras_by_country.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const CarrerasByCountryPage();
  var currentTap = 0;


  @override
  Widget build(BuildContext context) {

    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      //backgroundColor: Colors.white.withOpacity(0.9),
      //backgroundColor: Colors.transparent,
      floatingActionButton:
      isKeyboardShowing
        ? const SizedBox():FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () {
          currentScreen = const CarrerasByCountryPage();
          setState(() {
            currentTap = 0;
          });
        },
        child: const Icon(Icons.home,size: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const MorePage();
                        currentTap = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_horiz,
                          color: currentTap == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'المزيد',
                          style: TextStyle(
                            color: currentTap == 1 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const BlogPage();
                        currentTap = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.speaker_notes_outlined,
                          color: currentTap == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'المدونة',
                          style: TextStyle(
                            color: currentTap == 2 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CarrerasPage();
                        currentTap = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cases_outlined,
                          color: currentTap == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'الوظائف',
                          style: TextStyle(
                            color: currentTap == 3 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CompaniesPage();
                        currentTap = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business,
                          color: currentTap == 4 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'الشركات',
                          style: TextStyle(
                            color: currentTap == 4 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




