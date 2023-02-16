import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> autheticate(
    {required String email, required String password}) {
  String url = 'https://apiendpoint.fr/login';

  return http.post(
    Uri.parse(url),
    headers: <String, String>{
      "Content-type": "application/json; charset=UTF-8"
    },
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );
}
