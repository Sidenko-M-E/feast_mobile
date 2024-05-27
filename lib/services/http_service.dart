import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = '10.0.2.2:8080';

  Future<String> userSignIn(
      String email, String password, String notificationToken) async {
    final url = Uri.http(baseUrl, '/user/signin');
    final response = await http
        .post(url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "email": "$email",
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['accessToken'];
    } else if (response.statusCode == 401) {
      throw SignInException("401");
    } else if (response.statusCode == 404) {
      throw SignInException("404");
    }
    throw Exception("");
  }

  Future<String> userCheck(String name, String email, String password,
      String notificationToken) async {
    final url = Uri.http(baseUrl, '/user/check');
    final response = await http
        .post(url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "name": '$name',
              "email": "$email",
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return "";
    }else if (response.statusCode == 409) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = body["code"];
      if (msg == 'EMAIL_ALREADY_EXISTS') {
        throw SignUpException();
      } else
        throw Exception('Error in signUp');
    }
    throw Exception('Error in signUp');
  }

  Future<String> userSignUp(String name, String email, String password,
      String notificationToken) async {
    final url = Uri.http(baseUrl, '/user/signup');
    final response = await http
        .post(url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "name": "$name",
              "email": "$email",
              "phone": null,
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['accessToken'];
    }else if (response.statusCode == 409) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = body["code"];
      if (msg == 'EMAIL_ALREADY_EXISTS') {
        throw SignUpException();
      } else
        throw Exception('Error in signUp');
    }
    throw Exception('Error in signUp');
  }
}

class SignInException implements Exception {
  SignInException(this.statusCode);
  String statusCode;
}

class SignUpException implements Exception {}
