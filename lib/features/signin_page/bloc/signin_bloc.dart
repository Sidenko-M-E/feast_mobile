import 'dart:async';
import 'dart:io';

import 'package:feast_mobile_email/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?^&])[A-Za-z\d@$!%*#?^&]{3,}$');

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  late String email;
  late String? emailError;
  late String password;
  late String? passwordError;
  late bool isPasswordObscured;
  late bool isSigninEnabled;
  late HttpService httpService;

  SigninBloc({required this.httpService}) : super(SigninStateToRebuild()) {
    email = '';
    emailError = null;
    password = '';
    passwordError = null;
    isPasswordObscured = true;
    isSigninEnabled = false;
    on<SigninEventEmailChanged>(onEmailChanged);
    on<SigninEventPasswordChanged>(onPasswordChanged);
    on<SigninEventPasswordVisibilityChanged>(onPasswordVisibilityChanged);
    on<SigninEventSubmitButtonClicked>(onSubmitButtonClicked);
    on<SigninEventGoToSignup>(onGoToSignup);
  }

  FutureOr<void> onPasswordVisibilityChanged(
      SigninEventPasswordVisibilityChanged event, Emitter<SigninState> emit) {
    isPasswordObscured = !isPasswordObscured;
    debugPrint('${state.runtimeType}');
    emit(SigninStateToRebuild(
        isPasswordObscured: isPasswordObscured,
        emailValue: email,
        emailError: emailError,
        passwordValue: password,
        passwordError: passwordError,
        isSigninEnabled: isSigninEnabled));
  }

  FutureOr<void> onPasswordChanged(
      SigninEventPasswordChanged event, Emitter<SigninState> emit) {
    if (event.password != null) password = event.password!;

    if (password.length < 8) {
      passwordError = "Введите больше 7 символов";
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: false));
    } else if (!passwordRegExp.hasMatch(password)) {
      List additions = [];
      if (!password.contains(RegExp(r'[a-zA-Z]'))) additions.add('буквы');
      if (!password.contains(RegExp(r'[@$!%*#?^&]')))
        additions.add('спец.символы');
      if (!password.contains(RegExp(r'[0-9]'))) additions.add('цифры');
      if (additions.isNotEmpty)
        passwordError = 'Добавьте: ' + additions.join(', ');
      else
        passwordError = 'Уберите некорректные символы';
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: false));
    } else {
      passwordError = null;
      if (emailError != null || email == '')
        isSigninEnabled = false;
      else
        isSigninEnabled = true;
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: isSigninEnabled));
    }
  }

  FutureOr<void> onEmailChanged(
      SigninEventEmailChanged event, Emitter<SigninState> emit) {
    if (event.email != null) email = event.email!;

    if (email == '') {
      emailError = "Заполните поле";
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: false));
    } else if (!emailRegExp.hasMatch(email)) {
      emailError = "Не верный формат";
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: false));
    } else {
      emailError = null;
      if (passwordError != null || password == '')
        isSigninEnabled = false;
      else
        isSigninEnabled = true;
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: isSigninEnabled));
    }
  }

  FutureOr<void> onSubmitButtonClicked(
      SigninEventSubmitButtonClicked event, Emitter<SigninState> emit) async {
    try {
      emit(SigninStateLoading());
      final res = await HttpService.userSignIn(email, password, "");
      debugPrint(res);
      //
      // TODO Сделать навигацию на лист событий после успешного логина
      //
    } on SignInException catch (e) {
      if (e.statusCode == '401') {
        passwordError = 'Неверный пароль';
        isSigninEnabled = false;
        emit(SigninStateToRebuild(
            emailValue: email,
            emailError: emailError,
            passwordValue: password,
            passwordError: passwordError,
            isPasswordObscured: isPasswordObscured,
            isSigninEnabled: isSigninEnabled));
      } else if (e.statusCode == '404') {
        emailError = 'Такой email не зарегистрирован';
        isSigninEnabled = false;
        emit(SigninStateToRebuild(
            emailValue: email,
            emailError: emailError,
            passwordValue: password,
            passwordError: passwordError,
            isPasswordObscured: isPasswordObscured,
            isSigninEnabled: isSigninEnabled));
      }
    } on SocketException {
      emit(SigninStateAlert(
          alertTitle: "Ошибка связи",
          alertContent: "Проверьте интернет-соединение"));
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: isSigninEnabled));
    } on TimeoutException {
      emit(SigninStateAlert(
          alertTitle: "Ошибка связи",
          alertContent: "Слабое интернет-соединение"));
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: isSigninEnabled));
    } catch (_) {
      emit(SigninStateAlert(
          alertTitle: "Неизвестная ошибка", alertContent: "Попробуйте позже"));
      emit(SigninStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          isPasswordObscured: isPasswordObscured,
          isSigninEnabled: isSigninEnabled));
    }
  }

  FutureOr<void> onGoToSignup(
      SigninEventGoToSignup event, Emitter<SigninState> emit) {
    emit(SigninStateGoToSignup());
  }
}
