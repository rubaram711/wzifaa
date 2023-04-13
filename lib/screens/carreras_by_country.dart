import 'package:flutter/material.dart';
import '../backend/get_countries_and_cats.dart';
import '../backend/get_jobs.dart';
import '../consts/colors.dart';
import '../widgets/logo.dart';
import '../widgets/reusable_career_card.dart';

class CarrerasByCountryPage extends StatefulWidget {
  const CarrerasByCountryPage({Key? key}) : super(key: key);

  @override
  State<CarrerasByCountryPage> createState() => _CarrerasByCountryPageState();
}

class _CarrerasByCountryPageState extends State<CarrerasByCountryPage> {
  String countrySelected = '';
  int selectedCountryIndex=0;
  List<String> countriesList=[];
  List carrerasByCountryList = [];
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p;
    if (countrySelected.isNotEmpty) {
      p = await getJobsByCountry(countrySelected, from, length);
    } else {
      p = await getAllJobs(from, length);
    }
    carrerasByCountryList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          if (countrySelected.isNotEmpty) {
            p = await getJobsByCountry(countrySelected, from, length);
          } else {
            p = await getAllJobs(from, length);
          }
          carrerasByCountryList.addAll(p);
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


  bool isCountriesFetched=false;
  getCountriesForFilter() async{
    countriesList= await getCountries();
    setState(() {
      isCountriesFetched=true;
    });
  }

  @override
  void initState() {
    setState(() {
      countrySelected = '';
      selectedCountryIndex=0;
      carrerasByCountryList = [];
    });
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.14,
        backgroundColor: kBasicColor,
        title: const Logo(),
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
                        onTap: () async{
                          // alert(context, 'انتظر قليلا من فضلك');
                          await getCountriesForFilter();
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              context: context,
                              builder: (context) =>
                                  _buildBottomSheetForCountries(context,isCountriesFetched));
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
                              'وظائف حسب الدولة',
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
                                ? carrerasByCountryList.length + 1
                                : carrerasByCountryList.length,
                            itemBuilder: (context, index) {
                              if (index >= carrerasByCountryList.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                var id = carrerasByCountryList[index]['ID']??'';
                                var title =
                                    carrerasByCountryList[index]['post_title']??'';
                                var content = carrerasByCountryList[index]
                                    ['post_content']??'';
                                var postDate = carrerasByCountryList[index]['post_date']??'';
                                var companyName ='',location = '', views = '';
                                var emailLink ='', whatsappLink = '', phoneNumber = '',applicationLink='';
                                for (int i = 0; i < carrerasByCountryList[index]['Array'].length; i++) {
                                  if (carrerasByCountryList[index]['Array'][i]['meta_key'] == 'custom-company-name') {
                                    companyName = carrerasByCountryList[index]['Array'][i]['meta_value']??'';
                                  //  var company_Id = carrerasByCountryList[index]['Array'][i]['post_id']??'';
                                  }
                                  if (carrerasByCountryList[index]['Array'][i]
                                          ['meta_key'] ==
                                      '_noo_views_count') {
                                    views = carrerasByCountryList[index]
                                        ['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasByCountryList[index]['Array'][i]['meta_key'] == 'external-email') {
                                    emailLink = carrerasByCountryList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasByCountryList[index]['Array'][i]['meta_key'] == '_jm_company_field__whatsapp') {
                                    whatsappLink = carrerasByCountryList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasByCountryList[index]['Array'][i]['meta_key'] == '_jm_company_field__phone_number') {
                                    phoneNumber = carrerasByCountryList[index]['Array'][i]['meta_value']??'';
                                  }
                                  if (carrerasByCountryList[index]['Array'][i]['meta_key'] == 'external-application-link') {
                                    applicationLink = carrerasByCountryList[index]['Array'][i]['meta_value']??'';
                                  }
                                }
                                for (int i = 0; i < carrerasByCountryList[index]['tags'].length; i++) {
                                  if (carrerasByCountryList[index]['tags'][i]['taxonomy'] == 'job_location') {
                                    location = carrerasByCountryList[index]['tags'][i]['name']??'';
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

  SizedBox _buildBottomSheetForCountries(BuildContext context,bool isCountriesFetched) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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
                  'اختر دولة',
                  style: TextStyle(
                      color: kThirdColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            isCountriesFetched? Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemCount: countriesList.length,
                itemBuilder: (context, index) => Material(
                  child: RadioListTile(
                    title: Text(
                      countriesList[index],
                      style: const TextStyle(
                          fontSize: 14,
                          color: kThirdColor,
                          fontWeight: FontWeight.bold),
                    ),
                    value: index,
                    groupValue: selectedCountryIndex,
                    onChanged: (value) async{
                      setState(() {
                        selectedCountryIndex = value!;
                        index=value;
                        countrySelected=countriesList[selectedCountryIndex];
                        carrerasByCountryList = [];
                      });
                      await fetchData();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ) :const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
