import 'dart:async';
import 'dart:io';
import 'package:feast_mobile_email/models/user.dart';
import 'package:feast_mobile_email/services/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp passwordRegExp =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?^&])[A-Za-z\d@$!%*#?^&]{3,}$');

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  late String email;
  late String? emailError;
  late String password;
  late String? passwordError;
  late String name;
  late String? nameError;
  late bool isPasswordObscured;
  late bool isSignUpEnabled;
  late HttpService httpService;

  SignupBloc({required this.httpService}) : super(SignupStateToRebuild()) {
    email = '';
    emailError = null;
    password = '';
    passwordError = null;
    name = '';
    nameError = null;
    isPasswordObscured = true;
    isSignUpEnabled = false;
    on<SignupEventEmailChanged>(onEmailChanged);
    on<SignupEventPasswordChanged>(onPasswordChanged);
    on<SignupEventPasswordVisibilityChanged>(onPasswordVisibilityChanged);
    on<SignupEventNameChanged>(onNameChanged);
    on<SignupEventSubmitButtonClicked>(onSubmitButtonClicked);
    on<SignupEventGoToSignin>(onGoToSignin);
  }

  FutureOr<void> onEmailChanged(
      SignupEventEmailChanged event, Emitter<SignupState> emit) {
    if (event.email != null) email = event.email!;

    if (!emailRegExp.hasMatch(email)) {
      emailError = "Не верный формат";
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: false));
    } else {
      emailError = null;
      if (passwordError != null ||
          password == '' ||
          nameError != null ||
          name == '')
        isSignUpEnabled = false;
      else
        isSignUpEnabled = true;
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    }
  }

  FutureOr<void> onPasswordChanged(
      SignupEventPasswordChanged event, Emitter<SignupState> emit) {
    if (event.password != null) password = event.password!;

    if (password.length < 8) {
      passwordError = "Введите больше 7 символов";
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: false));
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
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: false));
    } else {
      passwordError = null;
      if (emailError != null || email == '' || nameError != null || name == '')
        isSignUpEnabled = false;
      else
        isSignUpEnabled = true;
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    }
  }

  FutureOr<void> onPasswordVisibilityChanged(
      SignupEventPasswordVisibilityChanged event, Emitter<SignupState> emit) {
    isPasswordObscured = !isPasswordObscured;

    emit(SignupStateToRebuild(
        isPasswordObscured: isPasswordObscured,
        emailValue: email,
        emailError: emailError,
        passwordValue: password,
        passwordError: passwordError,
        nameValue: name,
        nameError: nameError,
        isSignUpEnabled: isSignUpEnabled));
  }

  FutureOr<void> onSubmitButtonClicked(
      SignupEventSubmitButtonClicked event, Emitter<SignupState> emit) async {
    try {
      emit(SignupStateLoading());
      await httpService.userCheck(name, email, password, "");
      emit(SignupStateToRebuild());
      emit(SignupStateGoToOTP(
          user: User(
              name: name, email: email, password: password, accessToken: '')));
    } on SignUpException {
      emailError = 'Email занят';
      isSignUpEnabled = false;
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    } on SocketException {
      emit(SignupAlertState(
          alertTitle: "Ошибка связи",
          alertContent: "Проверьте интернет-соединение"));
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    } on TimeoutException {
      emit(SignupAlertState(
          alertTitle: "Ошибка связи",
          alertContent: "Слабое интернет-соединение"));
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    } catch (e) {
      emit(SignupAlertState(
          alertTitle: "Неизвестная ошибка", alertContent: "Попробуйте позже"));
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    }
  }

  FutureOr<void> onNameChanged(
      SignupEventNameChanged event, Emitter<SignupState> emit) {
    if (event.name != null) name = event.name!;

    if (name.length < 2) {
      nameError = "Введите больше одного символа";
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: false));
    } else {
      nameError = null;
      if (emailError != null ||
          email == '' ||
          passwordError != null ||
          password == '')
        isSignUpEnabled = false;
      else
        isSignUpEnabled = true;
      emit(SignupStateToRebuild(
          emailValue: email,
          emailError: emailError,
          passwordValue: password,
          passwordError: passwordError,
          nameValue: name,
          nameError: nameError,
          isPasswordObscured: isPasswordObscured,
          isSignUpEnabled: isSignUpEnabled));
    }
  }

  FutureOr<void> onGoToSignin(
      SignupEventGoToSignin event, Emitter<SignupState> emit) {
    emit(SignupStateGoToSignin());
  }
}
