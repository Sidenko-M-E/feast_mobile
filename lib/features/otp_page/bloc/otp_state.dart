part of 'otp_bloc.dart';

abstract class OtpState {}

abstract class OtpStateToListen extends OtpState {}

final class OtpStateAlert extends OtpStateToListen {
  OtpStateAlert({required this.alertTitle, required this.alertContent});

  final String alertTitle;
  final String alertContent;
}

final class OtpStateGoBack extends OtpStateToListen {}

final class OtpStateEmailOccupied extends OtpStateAlert {
  OtpStateEmailOccupied({required super.alertTitle, required super.alertContent});
}

final class OtpStateSignUpSuccess extends OtpStateToListen {
  OtpStateSignUpSuccess({required this.user});

  final user;
}

final class OtpStateToRebuild extends OtpState {
  final int secondsLeft;
  final String enteredCode;
  final bool requestCodeButtonEnabled;
  final bool signUpButtonEnabled;
  final bool codeInputEnabled;
  final String? codeError;
  final bool codeSendError;

  OtpStateToRebuild({
    this.secondsLeft = 0,
    this.codeError = null,
    this.enteredCode = '',
    this.requestCodeButtonEnabled = false,
    this.signUpButtonEnabled = false,
    this.codeInputEnabled = false,
    this.codeSendError = false,
  });

  OtpStateToRebuild.codeSendError({
    this.secondsLeft = 0,
    this.codeError = null,
    this.enteredCode = '',
    this.requestCodeButtonEnabled = true,
    this.signUpButtonEnabled = false,
    this.codeInputEnabled = false,
    this.codeSendError = true,
  });

    OtpStateToRebuild.codeSendSuccess({
    this.secondsLeft = otpRequestCooldown,
    this.codeError = null,
    this.enteredCode = '',
    this.requestCodeButtonEnabled = false,
    this.signUpButtonEnabled = false,
    this.codeInputEnabled = true,
    this.codeSendError = false,
  });
}

final class OtpStateLoading extends OtpStateToRebuild{
  OtpStateLoading() : super();
}