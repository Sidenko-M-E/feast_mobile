import 'dart:async';
import 'dart:io';

import 'package:feast_mobile_email/models/user.dart';
import 'package:feast_mobile_email/services/http_service.dart';
import 'package:flutter/material.dart';

class AuthVM extends ChangeNotifier {
  final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?^&])[A-Za-z\d@$!%*#?^&]{3,}$');

  User user = User.empty();
  bool loading = false;
  String? emailError = null;
  String? passwordError = null;
  bool canContinue = false;
  bool passwordObscured = true;
  ErrorMessage? errorMessage = null;

  clearFields() {
    emailError = null;
    passwordError = null;
    user = User.empty();
    canContinue = false;
    passwordObscured = true;
  }

  setUser(User? newUser) {
    notifyListeners();
  }

  setLoading() {
    loading = !loading;
    notifyListeners();
  }

  emailChanged(String? newVal) {
    if (newVal != null) user.email = newVal;
    if (user.email == '') {
      emailError = "Заполните поле";
      canContinue = false;
    } else if (!_emailRegExp.hasMatch(user.email)) {
      emailError = "Не верный формат";
      canContinue = false;
    } else {
      emailError = null;
      if (passwordError != null || user.password == '')
        canContinue = false;
      else
        canContinue = true;
    }
    notifyListeners();
  }

  passwordChanged(String? newVal) {
    if (newVal != null) user.password = newVal;
    if (user.password == '') {
      passwordError = "Заполните поле";
      canContinue = false;
    } else if (user.password.length < 8) {
      passwordError = 'Введите более 7 символов';
      canContinue = false;
    } else if (!_passwordRegExp.hasMatch(user.password)) {
      List additions = [];
      if (!user.password.contains(RegExp(r'[a-zA-Z]'))) additions.add('буквы');
      if (!user.password.contains(RegExp(r'[@$!%*#?^&]')))
        additions.add('спец.символы');
      if (!user.password.contains(RegExp(r'[0-9]'))) additions.add('цифры');
      if (additions.isNotEmpty)
        passwordError = 'Добавьте: ' + additions.join(', ');
      else
        passwordError = 'Уберите некорректные символы';
      canContinue = false;
    } else {
      passwordError = null;
      if (emailError != null || user.email == '')
        canContinue = false;
      else
        canContinue = true;
    }
    notifyListeners();
  }

  passwordVisibilityChanged() {
    passwordObscured = !passwordObscured;
    notifyListeners();
  }

  setErrorMessage(ErrorMessage? msg) {
    errorMessage = msg;
    notifyListeners();
  }

  Future<void> signin() async {
    try {
      setLoading();
      user.accessToken = await HttpService.userSignIn(
          user.email, user.password, user.accessToken);
    } on SignInException catch (e) {
      if (e.type == SignInFailure.WrongPassword) {
        passwordError = 'Неверный пароль';
        canContinue = false;
      } else if (e.type == SignInFailure.EmailAlreadyTaken) {
        emailError = 'Такой email не зарегистрирован';
        canContinue = false;
      }
    } on TimeoutException catch (_) {
      setErrorMessage(ErrorMessage(
        title: 'Ошибка связи',
        description: 'Слабое интернет-соединение',
      ));
    } on SocketException catch (_) {
      setErrorMessage(ErrorMessage(
        title: 'Ошибка связи',
        description: 'Проверьте интернет-соединение',
      ));
    } on Exception catch (_) {
      setErrorMessage(ErrorMessage(
        title: 'Неизвестная ошибка',
        description: 'Попробуйте позже',
      ));
    } finally {
      setLoading();
    }
  }
}

class ErrorMessage {
  ErrorMessage({required this.title, required this.description});

  String title;
  String description;
}
