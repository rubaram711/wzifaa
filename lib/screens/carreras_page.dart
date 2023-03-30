import 'package:flutter/material.dart';
import 'package:wazefaa/backend/get_jobs.dart';
import '../consts/colors.dart';
import '../consts/jobs_type_list.dart';
import '../widgets/reusable_career_card.dart';

class CarrerasPage extends StatefulWidget {
  const CarrerasPage({Key? key}) : super(key: key);

  @override
  State<CarrerasPage> createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage> {
  List carrerasList=[];
  //todo:make carrerasByCountryList empty after choosing country
  String typeSelected='';
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p;
    if(typeSelected.isNotEmpty) {
      p = await getJobsByCCT('', '', typeSelected, '', from, length);
    }else{
      p= await getAllJobs(from, length);
    }
    carrerasList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          if(typeSelected.isNotEmpty) {
            p = await getJobsByCCT('', '', typeSelected, '', from, length);
          }else{
            p= await getAllJobs(from, length);
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
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight:MediaQuery.of(context).size.height*0.10,
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
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.06,
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) =>
                                _buildBottomSheetForCarreras(context));
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.filter_alt,color: kThirdColor,),
                          SizedBox(width: 10,),
                          Text('أنواع الوظائف',style: TextStyle(color: kThirdColor, fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ),
                isDataFetched
                    ?SizedBox(
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
                          var id = carrerasList[index]['ID'];
                          var title = carrerasList[index]['post_title'];
                          var content = carrerasList[index]['post_content'];
                          var company = carrerasList[index]['company'];
                          var location = '', views = '';
                          for (int i = 0; i < carrerasList[index]['Array'].length; i++) {
                            if (carrerasList[index]['Array'][i]['meta_key']=='_location') {
                              location =
                              carrerasList[index]['Array'][i]['meta_value'];
                            }
                            if (carrerasList[index]['Array'][i]['meta_key']=='_noo_views_count') {
                              views =
                              carrerasList[index]['Array'][i]['meta_value'];
                            }
                          }
                          return ReusableCareerCard(
                            isWeInDetailsPage: false,
                            id: id,
                            title: title,
                            location: location,
                            views: views,
                            content: content,
                            company: company,
                            logo: 'assets/images/logo_circle.png',
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


  SizedBox _buildBottomSheetForCarreras(BuildContext context) {
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
              margin: const EdgeInsets.fromLTRB(15,15 ,15,0),
              height: MediaQuery.of(context).size.height * 0.29,
              child: ListView.builder(
                itemCount: jobsTypeList.length,
                itemBuilder: (context, index) => Material(
                  child: RadioListTile(
                    title: Text(
                      jobsTypeList[index],
                      style: const TextStyle(
                          fontSize: 14,
                          color: kThirdColor,
                          fontWeight: FontWeight.bold),
                    ),
                    value: jobsTypeList[index],
                    groupValue: typeSelected,
                    onChanged: (value) {
                      setState(() {
                        typeSelected = value;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
