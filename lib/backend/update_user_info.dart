import 'package:http/http.dart' as http;
import 'package:wazefaa/backend/save_user_info_locally.dart';
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future updateUserInfo(String id,String email, String username, String? phone) async {
  final uri = Uri.parse(kAddJobUrl);
  String token=await getTokenFromPref();
  var response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      "id": id,
      "email":email,
      "username": username,
      "phone": phone
    }),
  );
  print(token);
  print('id: $id,email:$email,username: $username,phone: $phone');
  var p = json.decode(response.body);
  print(p);
  return p;
}
