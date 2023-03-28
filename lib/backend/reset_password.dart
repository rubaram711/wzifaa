
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';


Future resetPassword(String email) async{
  final uri = Uri.parse(kLoginUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'user_login': email,
    }),
  );
  var p = json.decode(response.body);
  return response.statusCode;
}
