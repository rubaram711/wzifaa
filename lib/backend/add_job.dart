import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future addJob(String author,String title, String email, String content, String exp) async {
  final uri = Uri.parse(kAddJobUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      "author": author,
      "title":title,
      "content": content,
      "exp": exp,
      "email": email
    }),
  );
  return response;
}


//todo get redirect link then go to it
Future redirectEditJobUrl(String jobId) async {
  final uri = Uri.parse(kRedirectEditJobUrl).replace(queryParameters: {
    'job_id': jobId,
  });
  var response = await http.get(uri);
  return response;
}
