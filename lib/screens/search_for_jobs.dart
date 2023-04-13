import 'package:flutter/material.dart';
import 'package:wazefaa/backend/get_jobs.dart';
import 'package:wazefaa/widgets/reusable_dropdown_menu.dart';
import 'package:wazefaa/widgets/reusable_alert.dart';
import '../backend/get_countries_and_cats.dart';
import '../consts/jobs_type_list.dart';
import '../widgets/reusable_button.dart';
import '../widgets/reusable_career_card.dart';
import '../widgets/reusable_text_field.dart';

class SearchForJob extends StatefulWidget {
  const SearchForJob({Key? key}) : super(key: key);

  @override
  State<SearchForJob> createState() => _SearchForJobState();
}

class _SearchForJobState extends State<SearchForJob> {
  List carrerasBySearchList = [];
  int from = 0;
  int length = 10;
  String search = '', country = '', type = '', cat = '';
  bool isLoadMore = false;
  bool isDataFetched = false;
  bool isCatSelected=false,isTypeSelected=false,isCountrySelected=false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p = await getJobsByCCT(search, country, type, cat, from, length) ;
    carrerasBySearchList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          p = await getJobsByCCT(search, country, type, cat, from, length);
          carrerasBySearchList.addAll(p);
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

List<String> countriesList=[];
List<String> catsList=[];
bool isCountriesAndCatsFetched=false;
  getCountriesAndCats() async{
    countriesList= await getCountries();
    catsList= await getCats();
    setState(() {
      isCountriesAndCatsFetched=true;
    });
  }
@override
  void initState() {
    getCountriesAndCats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SearchTextField(
                        text: 'أدخل الكلمة المفتاحية التي تبحث عنها',
                        onPressSearchIcon: () {},
                        onChangedFunc: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isCountriesAndCatsFetched? Column(
                        children: [
                          ReusableDropdownButton(
                            hint: 'اختر البلد الذي تبحث عنه',
                            list: countriesList,
                            dropdownValue: country,
                            isItemSelected: isCountrySelected,
                            onChangeFunction: (value){
                              setState(() {
                                country=value;
                                isCountrySelected=true;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ReusableDropdownButton(
                            hint: 'اختر النوع الذي تبحث عنه',
                            list: jobsTypeList,
                            dropdownValue: type,
                            isItemSelected: isTypeSelected,
                            onChangeFunction: (value){
                              setState(() {
                                type=value;
                                isTypeSelected=true;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ReusableDropdownButton(
                            hint: 'اختر الفئة الذي تبحث عنها',
                            list: catsList,
                            dropdownValue: cat,
                            isItemSelected: isCatSelected,
                            onChangeFunction: (value){
                              setState(() {
                                cat=value;
                                isCatSelected=true;
                              });
                            },),
                        ],
                      ): const CircularProgressIndicator(),
                      const SizedBox(
                        height: 7,
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      ReUsableButton(
                          text: 'اضغط هنا للبحث',
                          onPressButton: () async{
                            setState(() {
                              isDataFetched = false;
                              carrerasBySearchList = [];
                            });
                            alert(context, 'انتظر قليلاَ من فضلك');
                            await fetchData();
                          }),
                    ],
                  ),
                ),
                isDataFetched
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: isLoadMore
                                ? carrerasBySearchList.length + 1
                                : carrerasBySearchList.length,
                            itemBuilder: (context, index) {
                              if (index >= carrerasBySearchList.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                var id =
                                    carrerasBySearchList[index]['ID'] ?? '';
                                var title = carrerasBySearchList[index]
                                        ['post_title'] ??
                                    '';
                                var content = carrerasBySearchList[index]
                                        ['post_content'] ??
                                    '';
                                var postDate = carrerasBySearchList[index]
                                        ['post_date'] ??
                                    '';
                                var companyName = '';
                                var location = '', views = '';
                                var emailLink ='', whatsappLink = '', phoneNumber = '',applicationLink='';
                                for (int i = 0;
                                    i <
                                        carrerasBySearchList[index]['Array']
                                            .length;
                                    i++) {
                                  if (carrerasBySearchList[index]['Array'][i]
                                          ['meta_key'] ==
                                      'custom-company-name') {
                                    companyName = carrerasBySearchList[index]
                                            ['Array'][i]['meta_value'] ??
                                        '';
                                  }
                                  if (carrerasBySearchList[index]['Array'][i]
                                          ['meta_key'] ==
                                      '_noo_views_count') {
                                    views = carrerasBySearchList[index]['Array']
                                            [i]['meta_value'] ??
                                        '';
                                  }
                                  if (carrerasBySearchList[index]['Array'][i]['meta_key'] == 'external-email') {
                                    emailLink = carrerasBySearchList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasBySearchList[index]['Array'][i]['meta_key'] == '_jm_company_field__whatsapp') {
                                    whatsappLink = carrerasBySearchList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasBySearchList[index]['Array'][i]['meta_key'] == '_jm_company_field__phone_number') {
                                    phoneNumber = carrerasBySearchList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasBySearchList[index]['Array'][i]['meta_key'] == 'external-application-link') {
                                    applicationLink = carrerasBySearchList[index]['Array'][i]['meta_value']??'';
                                  }
                                }
                                for (int i = 0;
                                    i <
                                        carrerasBySearchList[index]['tags']
                                            .length;
                                    i++) {
                                  if (carrerasBySearchList[index]['tags'][i]
                                          ['taxonomy'] ==
                                      'job_location') {
                                    location = carrerasBySearchList[index]
                                            ['tags'][i]['name'] ??
                                        '';
                                  }
                                }

                                return ReusableCareerCard(
                                  isWeInDetailsPage: false,
                                  id: id,
                                  title: title,
                                  date: postDate,
                                  location: location,
                                  views: views,
                                  content: content,
                                  company: companyName==''?'wzifaa':companyName,
                                  emailLink :emailLink,
                                  whatsappLink :whatsappLink,
                                  phoneNumber:whatsappLink,
                                  applicationLink:applicationLink,
                                  logo: '',
                                );
                              }
                            }),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Row(
//   //mainAxisSize: MainAxisSize.max,
//   children: <Widget>[
//     Flexible(
//       flex: 1,
//       child:Container(
//         // use this to match the Flex size..., is like using Expanded.
//         width: double.infinity,
//         // container defines the BoxConstrains of the children
//         decoration: BoxDecoration(
//           color: Colors.white24,
//           border: Border.all(color: Colors.white, width: 1),
//         ),
//         height: 30,
//         child: DropdownButton(
//             hint: Text("Unit"),
//             onChanged: (i) {},
//             underline: Container(),
//             items: List.generate(5, (i) {
//               return DropdownMenuItem(child: Text("item $i"));
//             })),
//       ),
//     ),
//
//     Flexible(
//       flex: 1,
//       child: Container(
//         // use this to match the Flex size..., is like using Expanded.
//         width: double.infinity,
//         // container defines the BoxConstrains of the children
//         decoration: BoxDecoration(
//           color: Colors.white24,
//           border: Border.all(color: Colors.white, width: 1),
//         ),
//         height: 30,
//         child: DropdownButton(
//             hint: Text("Unit"),
//             onChanged: (i) {},
//             underline: Container(),
//             items: List.generate(5, (i) {
//               return DropdownMenuItem(child: Text("item $i"));
//             })),
//       ),
//     ),
//
//     Flexible(
//       flex: 1,
//       child: Container(
//         // use this to match the Flex size..., is like using Expanded.
//         width: double.infinity,
//         // container defines the BoxConstrains of the children
//         decoration: BoxDecoration(
//           color: Colors.white24,
//           border: Border.all(color: Colors.white, width: 1),
//         ),
//         height: 30,
//         child: DropdownButton(
//             hint: Text("Unit"),
//             onChanged: (i) {},
//             underline: Container(),
//             items: List.generate(5, (i) {
//               return DropdownMenuItem(child: Text("item $i"));
//             })),
//       ),
//     ),
//   ],),
// const SizedBox(height: 7,),
// SearchForJobTextField(text: 'أدخل اسم البلد التي تبحث عنها',onChangedFunc: (value){
//   setState(() {
//     country=value;
//   });
// },),
// const SizedBox(height: 7,),
// SearchForJobTextField(text: 'أدخل اسم الفئة التي تبحث عنها',onChangedFunc: (value){
//   setState(() {
//     cat=value;
//   });
// },),
// const SizedBox(height: 7,),
// SearchForJobTextField(text: 'أدخل اسم نمط الوظيفة التي تبحث عنها',onChangedFunc: (value){
//   setState(() {
//     type=value;
//   });
// },),