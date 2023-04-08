import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> addCompanyToSP(Map<String, dynamic> com) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> favCompanies = await getCompaniesFromSP() ?? [];
  favCompanies.add(com);
  prefs.setString('fav_companies', jsonEncode(favCompanies));
}

Future<List<Map<String, dynamic>>> getCompaniesFromSP() async {
  final prefs = await SharedPreferences.getInstance();
  final List<Map<String, dynamic>> favCompanies =
      List<Map<String, dynamic>>.from(
          jsonDecode(prefs.getString('fav_companies') ?? '[]'));
  return favCompanies;
}

Future<void> addJobToSP(Map<String, dynamic> job) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> favJobs = await getJobsFromSP() ?? [];
  favJobs.add(job);
  prefs.setString('fav_jobs', jsonEncode(favJobs));
}

Future<List<Map<String, dynamic>>> getJobsFromSP() async {
  final prefs = await SharedPreferences.getInstance();
  final List<Map<String, dynamic>> favJobs = List<Map<String, dynamic>>.from(
      jsonDecode(prefs.getString('fav_jobs') ?? '[]'));
  return favJobs;
}


Future<void> addCVToSP(Map<String, dynamic> cv) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> favCVs = await getCVsFromSP() ?? [];
  favCVs.add(cv);
  print(favCVs);
  prefs.setString('fav_CVs', jsonEncode(favCVs));
}

Future<List<Map<String, dynamic>>> getCVsFromSP() async {
  final prefs = await SharedPreferences.getInstance();
  final List<Map<String, dynamic>> favCVs = List<Map<String, dynamic>>.from(
      jsonDecode(prefs.getString('fav_CVs') ?? '[]'));
  return favCVs;
}
