import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazefaa/consts/URLs.dart';

Future getPosts(String search, int from, int length) async {
  final uri = Uri.parse(kGetPostsUrl);
  var response = await http.post(
    uri,
    body: search.isEmpty
        ? jsonEncode(<String, dynamic>{'from': from, 'length': length})
        : jsonEncode(<String, dynamic>{
            'search': search,
            'from': from,
            'length': length
          }),
  );

  var p = json.decode(response.body);
  return p;
}
