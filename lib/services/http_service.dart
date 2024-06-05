import 'dart:convert';
import 'package:feast_mobile_email/models/category.dart';
import 'package:feast_mobile_email/models/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/filters.dart';

abstract class HttpService {
  static const Duration timeoutDuration = Duration(seconds: 5);
  static const String baseUrl = '10.0.2.2:8080';

  static Future<List<Event>> getEvents(Filters filters) async {
    Map<String, dynamic> params = {
      'start': filters.start,
      'end': filters.end,
      'age': '${filters.age}',
    };
    List<int> catIds = filters.categories.map((CategoryModel cat) => cat.id).toList();
    if (catIds.length > 0) params.addAll({'catIds': '${catIds.join(',')}'});

    Uri url = Uri.http(baseUrl, 'event', params);
    final res = await http.get(url).timeout(timeoutDuration);

    if (res.statusCode == 200) {
      final List<Event> events;
      events = List<Event>.from(json
          .decode(utf8.decode(res.bodyBytes))
          .map((model) => Event.fromJson(model)));
      debugPrint(events.toString());
      return events;
    }

    return [];
  }

  static Future<List<CategoryModel>> getCategories() async {
    final res =
        await http.get(Uri.http(baseUrl, '/category')).timeout(timeoutDuration);

    if (res.statusCode == 200)
      return List<CategoryModel>.from(json
          .decode(utf8.decode(res.bodyBytes))
          .map((model) => CategoryModel.fromJson(model)));

    return [];
  }

  static Future<CategoryModel?> getCategoryById(int id) async {
    final res = await http
        .get(Uri.http(baseUrl, '/category/$id'))
        .timeout(timeoutDuration);

    if (res.statusCode == 200)
      return CategoryModel.fromJson(json.decode(utf8.decode(res.bodyBytes)));

    return null;
  }

  static Future<String> userSignIn(
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
        .timeout(timeoutDuration);

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

  static Future<String> userCheck(String name, String email, String password,
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
        .timeout(timeoutDuration);

    if (response.statusCode == 200) {
      return "";
    } else if (response.statusCode == 409) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = body["code"];
      if (msg == 'EMAIL_ALREADY_EXISTS') {
        throw SignUpException();
      } else
        throw Exception('Error in signUp');
    }
    throw Exception('Error in signUp');
  }

  static Future<String> userSignUp(String name, String email, String password,
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
        .timeout(timeoutDuration);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['accessToken'];
    } else if (response.statusCode == 409) {
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
