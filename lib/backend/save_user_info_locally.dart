import 'package:shared_preferences/shared_preferences.dart';

saveUserInfoLocally(String token, String role, String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  prefs.setString('role', role);
  prefs.setString('ID', id);
}

Future<Map> getUserInfoFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String role = prefs.getString('role') ?? '';
  String id = prefs.getString('ID') ?? '';
  return {
    'token': token,
    'role': role,
    'ID': id,
  };
}

Future<String> getTokenFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  return token;
}

Future<String> getIdFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('ID') ?? '';
  return id;
}

Future<String> getRoleFromPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String role = prefs.getString('role') ?? '';
  return role;
}
