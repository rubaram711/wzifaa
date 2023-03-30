import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';


Future getAllJobs(int from,int length) async {
  final uri = Uri.parse(kGetAllJobsUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'from': from,
      'length':length
    }),
  );

  var p = json.decode(response.body);
  return p;
}


Future getJobsByCountry(String country,int from,int length) async {
  final uri = Uri.parse(kGetJobsByCountryUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'country': country,
      'from': from,
      'length':length
    }),
  );

  var p = json.decode(response.body);
  return p;
}


Future getJobsByCCT(String search,String country,String type,String cat,int from,int length) async {
  final uri = Uri.parse(kGetJobsByCCTUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'search': search,
      'country': country,
      'type': type,
      'cat': cat,
      'from': from,
      'length':length
    }),
  );

  var p = json.decode(response.body);
  return p;
}