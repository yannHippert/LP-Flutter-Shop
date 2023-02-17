import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';

class ApiClient {
  static Future<bool> autheticate(String email, String password) async {
    //final response = await autheticate(email: email, password: password);
    //if (response.statusCode == 200) {
    int statusCode =
        await Future.delayed(const Duration(seconds: 2), () => 200);
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }
}
