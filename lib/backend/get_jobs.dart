import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future getAllJobs(int from, int length) async {
  final uri = Uri.parse(kGetAllJobsUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(<String, dynamic>{'from': from, 'length': length}),
  );

  var p = json.decode(response.body);
  return p;
}

Future getJobsByCountry(String country, int from, int length) async {
  final uri = Uri.parse(kGetJobsByCountryUrl);
  var response = await http.post(
    uri,
    body: jsonEncode(
        <String, dynamic>{'country': country, 'from': from, 'length': length}),
  );
  var p =[];
  if (response.body.isNotEmpty) {
    p = json.decode(response.body);
  }
  return p;
}

Future getJobsByCCT(String search, String country, String type, String cat,
    int from, int length) async {
  final uri = Uri.parse(kGetJobsByCCTUrl);
  var response = await http.post(uri,
      body: country.isEmpty && cat.isEmpty && type.isEmpty
          ? jsonEncode(<String, dynamic>{
              'search': search,
              'from': from,
              'length': length
            })
          : country.isNotEmpty && cat.isNotEmpty && type.isNotEmpty
              ? jsonEncode(<String, dynamic>{
                  'search': search,
                  'country': country,
                  'type': type,
                  'cat': cat,
                  'from': from,
                  'length': length
                })
              : country.isEmpty && cat.isEmpty && type.isNotEmpty
                  ? jsonEncode(<String, dynamic>{
                      'search': search,
                      'type': type,
                      'from': from,
                      'length': length
                    })
                  : cat.isEmpty && type.isEmpty && country.isNotEmpty
                      ? jsonEncode(<String, dynamic>{
                          'search': search,
                          'country': country,
                          'from': from,
                          'length': length
                        })
                      : country.isEmpty && type.isEmpty && cat.isNotEmpty
                          ? jsonEncode(<String, dynamic>{
                              'search': search,
                              'cat': cat,
                              'from': from,
                              'length': length
                            })
                          : cat.isEmpty && type.isNotEmpty && country.isNotEmpty
                              ? jsonEncode(<String, dynamic>{
                                  'search': search,
                                  'country': country,
                                  'type': type,
                                  'from': from,
                                  'length': length
                                })
                              : country.isEmpty && type.isNotEmpty && cat.isNotEmpty
                                  ? jsonEncode(<String, dynamic>{
                                      'search': search,
                                      'cat': cat,
                                      'type': type,
                                      'from': from,
                                      'length': length
                                    })
                                  : jsonEncode(<String, dynamic>{
                                      'search': search,
                                      'cat': cat,
                                      'country': country,
                                      'from': from,
                                      'length': length
                                    }));
  var p = [];
  print('response.body ${response.body}');
  if (response.body.isNotEmpty) {
    p = json.decode(response.body);
    print('p $p');
  }
  return p;
}
