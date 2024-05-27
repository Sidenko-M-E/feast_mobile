part of 'signin_bloc.dart';

abstract class SigninState {}

abstract class SigninStateToListen extends SigninState {}

class SigninStateAlert extends SigninStateToListen {
  SigninStateAlert({required this.alertTitle, required this.alertContent});

  final String alertTitle;
  final String alertContent;
}

class SigninStateGoToSignup extends SigninStateToListen {}

class SigninStateToRebuild extends SigninState {
  final String emailValue;
  final String? emailError;
  final String passwordValue;
  final String? passwordError;
  final bool isPasswordObscured;
  final bool isSigninEnabled;

  SigninStateToRebuild(
      {this.emailValue = '',
      this.emailError = null,
      this.passwordValue = '',
      this.passwordError = null,
      this.isPasswordObscured = true,
      this.isSigninEnabled = false});
}


class SigninStateLoading extends SigninStateToRebuild {
  SigninStateLoading() : super();
}
