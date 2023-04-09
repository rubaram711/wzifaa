import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future getCountries() async {
  final uri = Uri.parse(kGetCountriesUrl);
  var response = await http.post(uri);
  var p = json.decode(response.body);
  List<String> countries=[];
  for(int i=0;i<p.length;i++){
    countries.add(p[i]['country_name']);
  }
  return countries;
}


Future getCats() async {
  final uri = Uri.parse(kGetCatsUrl);
  var response = await http.post(uri);
  var p = json.decode(response.body);
  List<String> cats=[];
  for(int i=0;i<p.length;i++){
    cats.add(p[i]['cat_name']);
  }
  return cats;
}
