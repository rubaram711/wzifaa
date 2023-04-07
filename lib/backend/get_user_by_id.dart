import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';



Future getUserById(String? id) async {
  final uri = Uri.parse(kGetUserByIdUrl);
  var response = await http.post(
    uri,
    body:jsonEncode(<String, dynamic>{
      'id': id,
    }),
  );

  var p = json.decode(response.body);
  return p[0];
}