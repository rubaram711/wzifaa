import 'package:flutter/material.dart';
import 'package:wazefaa/backend/get_jobs.dart';
import '../consts/colors.dart';
import '../consts/jobs_type_list.dart';
import '../widgets/reusable_career_card.dart';

String typeSelected = '';

class CarrerasPage extends StatefulWidget {
  const CarrerasPage({Key? key}) : super(key: key);

  @override
  State<CarrerasPage> createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage> {
  List carrerasList = [];
  //todo:make carrerasByCountryList empty after choosing country

  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    // ignore: prefer_typing_uninitialized_variables
    var p;
    if (typeSelected.isNotEmpty) {
      p = await getJobsByCCT('', '', typeSelected, '', from, length);
    } else {
      p = await getAllJobs(from, length);
    }
    carrerasList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          if (typeSelected.isNotEmpty) {
            p = await getJobsByCCT('', '', typeSelected, '', from, length);
          } else {
            p = await getAllJobs(from, length);
          }
          carrerasList.addAll(p);
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
    typeSelected==''? fetchData():fetchData();
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
          'وظائف اليوم',
          style: TextStyle(
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
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (context) =>
                                  const BuildBottomSheetForCarreras());
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.filter_alt,
                              color: kThirdColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'أنواع الوظائف',
                              style: TextStyle(
                                  color: kThirdColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/search_for_job');
                          // showSearch(context: context, delegate: MySearchDelegate());
                        },
                        child: const Icon(
                          Icons.search,
                          color: kThirdColor,
                        ),
                      ),
                    ],
                  ),
                ),
                isDataFetched
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: isLoadMore
                                ? carrerasList.length + 1
                                : carrerasList.length,
                            itemBuilder: (context, index) {
                              if (index >= carrerasList.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                var id = carrerasList[index]['ID'] ?? '';
                                var title = carrerasList[index]['post_title']??'';
                                var content = carrerasList[index]['post_content']??'';
                                var postDate = carrerasList[index]['post_date']??'';
                                var companyName ='';
                                var location = '', views = '';
                                for (int i = 0; i < carrerasList[index]['Array'].length; i++) {
                                  if (carrerasList[index]['Array'][i]['meta_key'] == 'custom-company-name') {
                                    companyName = carrerasList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasList[index]['Array'][i]['meta_key'] == '_noo_views_count') {
                                    views = carrerasList[index]['Array'][i]['meta_value']??'';
                                  }
                                }
                                for (int i = 0; i < carrerasList[index]['tags'].length; i++) {
                                  if (carrerasList[index]['tags'][i]['taxonomy'] == 'job_location') {
                                    location = carrerasList[index]['tags'][i]['name']??'';
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
                                  company: companyName,
                                  logo: '',
                                );
                              }
                            }),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildBottomSheetForCarreras extends StatefulWidget {
  const BuildBottomSheetForCarreras({Key? key}) : super(key: key);

  @override
  State<BuildBottomSheetForCarreras> createState() =>
      _BuildBottomSheetForCarrerasState();
}

class _BuildBottomSheetForCarrerasState
    extends State<BuildBottomSheetForCarreras> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              color: Colors.white,
              child: const Center(
                child: Text(
                  'اختر نوع الوظيفة',
                  style: TextStyle(
                      color: kThirdColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              height: MediaQuery.of(context).size.height * 0.29,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RadioListTile(
                      title: Text(
                        jobsTypeList[0],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                      value: jobsTypeList[0],
                      groupValue: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        jobsTypeList[1],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                      value: jobsTypeList[1],
                      groupValue: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        jobsTypeList[2],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                      value: jobsTypeList[2],
                      groupValue: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        jobsTypeList[3],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                      value: jobsTypeList[3],
                      groupValue: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        jobsTypeList[4],
                        style: const TextStyle(
                            fontSize: 14,
                            color: kThirdColor,
                            fontWeight: FontWeight.bold),
                      ),
                      value: jobsTypeList[4],
                      groupValue: typeSelected,
                      onChanged: (value) {
                        setState(() {
                          typeSelected = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// SizedBox _buildBottomSheetForCarreras(BuildContext context) {
//   return SizedBox(
//     height: MediaQuery.of(context).size.height * 0.4,
//     child: Directionality(
//       textDirection: TextDirection.rtl,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 60,
//             color: Colors.white,
//             child: const Center(
//               child: Text(
//                 'اختر نوع الوظيفة',
//                 style: TextStyle(
//                     color: kThirdColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.fromLTRB(15,15 ,15,0),
//             height: MediaQuery.of(context).size.height * 0.29,
//             child: ListView.builder(
//               itemCount: jobsTypeList.length,
//               itemBuilder: (context, index) {
//                  typeSelected=jobsTypeList[0];
//                 return RadioListTile(
//                   title: Text(
//                     jobsTypeList[index],
//                     style: const TextStyle(
//                         fontSize: 14,
//                         color: kThirdColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   value: jobsTypeList[index],
//                   groupValue: typeSelected,
//                   onChanged: (value) {
//                     setState(() {
//                       typeSelected = value;
//                       print(typeSelected);
//                     });
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
