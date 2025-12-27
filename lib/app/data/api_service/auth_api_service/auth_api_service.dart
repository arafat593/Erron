import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  static Future<dynamic> signUpRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw "Sign up request failed $e";
    }
  }
}
