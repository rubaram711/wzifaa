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
    print('${p['ID']}');
    print(p['token']);
    String i=await getIdFromPref();
    String t=await getTokenFromPref();
    print(i);
    print(t);
  return 'Success';
  }

//  {token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Ilx1MDY0N1x1MDY0NFx1MDYyN1x1MDY0NCIsImV4cCI6MTY4MTI0NDgxOH0.G_0R1JCdD_JTi4JckT26ZecADiLsF7BvVaS5Vg-L2iU, role: candidate, msg: Success, ID: 219}


}
