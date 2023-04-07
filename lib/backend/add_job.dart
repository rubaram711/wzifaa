import 'package:http/http.dart' as http;
import 'package:wazefaa/backend/save_user_info_locally.dart';
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future addJob(String author,String title, String email, String content, String exp) async {
  final uri = Uri.parse(kAddJobUrl);
  String token=await getTokenFromPref();
  var response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      "author": author,
      "title":title,
      "content": content,
      "exp": exp,
      "email": email
    }),
  );
  var p = json.decode(response.body);
  return p;
}


// Future redirectEditJobUrl(int jobId) async {
//   final uri = Uri.parse(kRedirectEditJobUrl).replace(queryParameters: {
//     'job_id': jobId,
//   });
//   var response = await http.get(uri);
//   var p = json.decode(response.body);
//   return p;
// }
