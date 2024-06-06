part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupEventNameChanged extends SignupEvent {
  String? name;
  SignupEventNameChanged({this.name});
}

class SignupEventEmailChanged extends SignupEvent {
  String? email;
  SignupEventEmailChanged({this.email});
}

class SignupEventPasswordChanged extends SignupEvent {
  String? password;
  SignupEventPasswordChanged({this.password});
}

class SignupEventPasswordVisibilityChanged extends SignupEvent {}


class SignupEventSubmitButtonClicked extends SignupEvent {}

class SignupEventGoToSignin extends SignupEvent {}
