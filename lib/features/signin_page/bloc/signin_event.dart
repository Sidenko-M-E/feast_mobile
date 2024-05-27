part of 'signin_bloc.dart';

abstract class SigninEvent {}

class SigninEventEmailChanged extends SigninEvent {
  String? email;
  SigninEventEmailChanged({this.email});
}

class SigninEventPasswordChanged extends SigninEvent {
  String? password;
  SigninEventPasswordChanged({this.password});
}

class SigninEventPasswordVisibilityChanged extends SigninEvent {}

class SigninEventSubmitButtonClicked extends SigninEvent {}

class SigninEventGoToSignup extends SigninEvent {}
