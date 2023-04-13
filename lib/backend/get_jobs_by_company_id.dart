import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future getJobsByCompanyId(int comId, int from, int length) async {
  final uri = Uri.parse(kGetJobsByCompanyIdUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'comid': comId,
      'from': from,
      'length': length
    }),
  );

  var p = json.decode(response.body);
  return p;
}

