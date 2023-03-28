import 'package:http/http.dart' as http;
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
    //todo save next info locally
    //{token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InJ1YmEiLCJleHAiOjE2ODAwMzM2NDJ9.cReWa7B_lSjUH16FLataFzK6PyMFiYBm_kW4M9M5EVo,
    // role: employer,
    // msg: Success,
    // ID: 177}
  return 'Success';
  }




}
