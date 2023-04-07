import 'package:http/http.dart' as http;
import 'package:wazefaa/backend/save_user_info_locally.dart';
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';


Future login(String email,String pass) async{
  final uri = Uri.parse(kLoginUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'pass': pass,
    }),
  );
  var p = json.decode(response.body);
  if(p['msg']=='Invalid User'){return 'error';}
  else{
    await saveUserInfoLocally(p['token'],p['role'], '${p['ID']}');
  return 'Success';
  }

// {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im1vaGFtbWFkIHNhIiwiZXhwIjoxNjgwNzc4MzE3fQ.Y1uNy6irWA2BLz33wSqGBPN5AhQWugIg5xSHOWcviS4,
// role: employer, msg: Success, ID: 194}


}
