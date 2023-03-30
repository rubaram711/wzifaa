import 'package:http/http.dart' as http;
import 'package:wazefaa/backend/save_user_info_locally.dart';
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';


Future register(String username,String email,String pass,int role) async{
  final uri = Uri.parse(kRegisterUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{
      'username': username,
      'email': email,
      'pass': pass,
      'role': role,
    }),
  );

  var p = json.decode(response.body);
  print(p);
  if(p['msg']=='already exists'){return 'error';}
  else{
    await saveUserInfoLocally(p['token'],p['role'],'${p['ID']}');
    return 'Success';
  }
}
//{token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InJ1YmEiLCJleHAiOjE2ODAwMzM2NDJ9.cReWa7B_lSjUH16FLataFzK6PyMFiYBm_kW4M9M5EVo,
// role: employer,
// msg: Success,
// ID: 177}