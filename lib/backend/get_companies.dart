import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';


Future<List> getAllCompanies(int from,int length) async {
  final uri = Uri.parse(kGetAllCompaniesUrl);
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


Future getCompaniesBy(String search,int from,int length) async {
  final uri = Uri.parse(kGetCompaniesByUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'search': search,
      'from': from,
      'length':length
    }),
  );

  var p = json.decode(response.body);
  return p;
}