part of 'otp_bloc.dart';

abstract class OtpEvent {}

class OtpCodeChanged extends OtpEvent {
  OtpCodeChanged({required this.newValue});
  final String newValue;
}

class OtpCodeComplete extends OtpEvent {
  OtpCodeComplete({required this.newValue});
  final String newValue;
}

class OtpTimerTicked extends OtpEvent {
  OtpTimerTicked({required this.secondsLeft});
  final int secondsLeft;
}

class OtpRequestNewCode extends OtpEvent {}


class OtpGoBack extends OtpEvent {}

class OtpSignUpButtonClicked extends OtpEvent {}
