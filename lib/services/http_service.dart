import 'dart:convert';
import 'package:feast_mobile_email/models/category.dart';
import 'package:feast_mobile_email/models/event.dart';
import 'package:feast_mobile_email/models/filters.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class HttpService {
  static const Duration timeoutDuration = Duration(seconds: 5);
  static const String baseUrl = '10.0.2.2:8080';

  static Future<List<Event>> getEvents(Filters filters) async {
    Map<String, dynamic> params = {
      'start': filters.start,
      'end': filters.end,
      'age': '${filters.age}',
    };
    List<int> catIds =
        filters.categories.map((CategoryModel cat) => cat.id).toList();
    if (catIds.length > 0) params.addAll({'catIds': '${catIds.join(',')}'});

    final res = await http
        .get(Uri.http(baseUrl, '/event', params))
        .timeout(timeoutDuration);

    if (res.statusCode == 200)
      return List<Event>.from(json
          .decode(utf8.decode(res.bodyBytes))
          .map((model) => Event.fromJson(model)));
    else
      throw InternalException();
  }

  static Future<List<CategoryModel>> getCategories() async {
    final res =
        await http.get(Uri.http(baseUrl, '/category')).timeout(timeoutDuration);

    if (res.statusCode == 200)
      return List<CategoryModel>.from(json
          .decode(utf8.decode(res.bodyBytes))
          .map((model) => CategoryModel.fromJson(model)));
    else
      throw InternalException();
  }

  // static Future<CategoryModel?> getCategoryById(int id) async {
  //   final res = await http
  //       .get(Uri.http(baseUrl, '/category/$id'))
  //       .timeout(timeoutDuration);

  //   if (res.statusCode == 200)
  //     return CategoryModel.fromJson(json.decode(utf8.decode(res.bodyBytes)));
  //   //TODO handle code 404 and 500
  //   else
  //     return null;
  // }

  static Future<String> userSignIn(
      String email, String password, String notificationToken) async {
    final Response response = await http
        .post(Uri.http(baseUrl, '/user/signin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "email": "$email",
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(timeoutDuration);

    if (response.statusCode == 200)
      return (jsonDecode(response.body) as Map<String, dynamic>)['accessToken'];
    else if (response.statusCode == 401)
      throw SignInException(SignInFailure.WrongPassword);
    else if (response.statusCode == 404)
      throw SignInException(SignInFailure.EmailAlreadyTaken);
    else
      throw InternalException();
  }

  static Future<void> userCheck(String name, String email, String password,
      String notificationToken) async {
    final response = await http
        .post(Uri.http(baseUrl, '/user/check'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "name": '$name',
              "email": "$email",
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(timeoutDuration);

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 409) {
      final msg = (jsonDecode(response.body) as Map<String, dynamic>)['code'];
      if (msg == 'EMAIL_ALREADY_EXISTS')
        throw SignUpException(SignUpFailure.EmailAlreadyExists);
      else
        throw SignUpException(SignUpFailure.PhoneAlreadyExists);
    } else
      throw InternalException();
  }

  static Future<String> userSignUp(String name, String email, String password,
      String notificationToken) async {
    final response = await http
        .post(Uri.http(baseUrl, '/user/signup'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(<String, String?>{
              "name": "$name",
              "email": "$email",
              "phone": null,
              "password": "$password",
              "notificationToken": "$notificationToken"
            }))
        .timeout(timeoutDuration);

    if (response.statusCode == 200)
      return (jsonDecode(response.body) as Map<String, dynamic>)['accessToken'];
    else if (response.statusCode == 409) {
      final msg = (jsonDecode(response.body) as Map<String, dynamic>)["code"];
      if (msg == 'EMAIL_ALREADY_EXISTS') {
        throw SignUpException(SignUpFailure.EmailAlreadyExists);
      } else
        throw SignUpException(SignUpFailure.PhoneAlreadyExists);
    }
    throw InternalException();
  }
}

class SignInException implements Exception {
  SignInException(this.type);
  SignInFailure type;
}

enum SignInFailure {
  WrongPassword,
  EmailAlreadyTaken,
}

class SignUpException implements Exception {
  SignUpException(this.type);
  SignUpFailure type;
}

enum SignUpFailure {
  EmailAlreadyExists,
  PhoneAlreadyExists,
}

class InternalException implements Exception {}
