part of 'signup_bloc.dart';

abstract class SignupState {}

abstract class SignupStateToListen extends SignupState {}

class SignupAlertState extends SignupStateToListen {
  SignupAlertState({required this.alertTitle, required this.alertContent});

  final String alertTitle;
  final String alertContent;
}

class SignupStateGoToOTP extends SignupStateToListen {
  SignupStateGoToOTP({required this.user});

  final user;
}

class SignupStateGoToSignin extends SignupStateToListen {}

class SignupStateToRebuild extends SignupState {
  final String emailValue;
  final String? emailError;
  final String passwordValue;
  final String? passwordError;
  final String nameValue;
  final String? nameError;
  final bool isPasswordObscured;
  final bool isSignUpEnabled;

  SignupStateToRebuild({
    this.isPasswordObscured = true,
    this.emailValue = '',
    this.emailError = null,
    this.passwordValue = '',
    this.passwordError = null,
    this.nameValue = '',
    this.nameError = null,
    this.isSignUpEnabled = false,
  });
}

class SignupStateLoading extends SignupStateToRebuild {
  SignupStateLoading() : super();
}
