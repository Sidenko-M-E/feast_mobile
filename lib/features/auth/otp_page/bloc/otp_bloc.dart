import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:feast_mobile_email/models/user.dart';
import 'package:feast_mobile_email/services/email_service.dart';
import 'package:feast_mobile_email/services/http_service.dart';
import 'package:feast_mobile_email/services/otp_service.dart';

part 'otp_event.dart';
part 'otp_state.dart';

const int otpRequestCooldown = 30;

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  late OTPService otpService;
  late HttpService httpService;
  late User user;
  late int secondsLeft;
  late String? codeError;
  late String enteredCode;
  late bool requestCodeButtonEnabled;
  late bool signUpButtonEnabled;

  StreamSubscription<int>? tickerSubs;

  OtpBloc({required this.user}) : super(OtpStateLoading()) {
    otpService = OTPService();
    secondsLeft = otpRequestCooldown;
    codeError = null;
    enteredCode = '';
    requestCodeButtonEnabled = false;
    signUpButtonEnabled = false;

    on<OtpCodeChanged>(onOtpCodeChanged);
    on<OtpCodeComplete>(onOtpCodeComplete);
    on<OtpRequestNewCode>(onOtpRequestNewCode);
    on<OtpTimerTicked>(onOtpTimerTicked);
  }

  @override
  Future<void> close() {
    tickerSubs?.cancel();
    return super.close();
  }

  onOtpRequestNewCode(OtpRequestNewCode event, Emitter<OtpState> emit) async {
    final code = otpService.generateOTP();
    try {
      emit(OtpStateLoading());
      await EmailService().sendEmail(To: user.email, OTP: code).timeout(Duration(seconds: 3));
      tickerSubs?.cancel();
      tickerSubs = Stream.periodic(const Duration(seconds: 1),
              (i) => OTPService.otpRequestCooldown - i - 1)
          .take(OTPService.otpRequestCooldown)
          .listen(
              (secondsLeft) => add(OtpTimerTicked(secondsLeft: secondsLeft)));
      emit(OtpStateToRebuild.codeSendSuccess());
    } catch (e) {
      emit(OtpStateToRebuild.codeSendError());
    }
  }

  onOtpTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    secondsLeft = event.secondsLeft;
    if (event.secondsLeft == 0) {
      emit(OtpStateToRebuild(
        secondsLeft: 0,
        codeError: codeError,
        enteredCode: enteredCode,
        requestCodeButtonEnabled: true,
        signUpButtonEnabled: signUpButtonEnabled,
        codeInputEnabled: true,
        codeSendError: false,
      ));
    } else {
      emit(OtpStateToRebuild(
        secondsLeft: secondsLeft,
        codeError: codeError,
        enteredCode: enteredCode,
        requestCodeButtonEnabled: false,
        signUpButtonEnabled: signUpButtonEnabled,
        codeInputEnabled: true,
        codeSendError: false,
      ));
    }
  }

  onOtpCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    enteredCode = event.newValue;
    emit(OtpStateToRebuild(
      secondsLeft: secondsLeft,
      codeError: codeError,
      enteredCode: enteredCode,
      requestCodeButtonEnabled: requestCodeButtonEnabled,
      signUpButtonEnabled: signUpButtonEnabled,
      codeInputEnabled: true,
      codeSendError: false,
    ));
  }

  onOtpCodeComplete(OtpCodeComplete event, Emitter<OtpState> emit) async {
    switch (otpService.verifyOTP(event.newValue)) {
      case OtpVerificationError.None:
        try {
          emit(OtpStateLoading());
          user.accessToken = await HttpService.userSignUp(
              user.name, user.email, user.password, "");
          emit(OtpStateSignUpSuccess(user: user));
        } on SignUpException {
          emit(OtpStateEmailOccupied(
              alertTitle: 'Email уже занят',
              alertContent: 'Попробуйте другой email'));
          emit(OtpStateToRebuild(
            secondsLeft: secondsLeft,
            codeError: codeError,
            enteredCode: enteredCode,
            requestCodeButtonEnabled: requestCodeButtonEnabled,
            signUpButtonEnabled: signUpButtonEnabled,
            codeInputEnabled: true,
            codeSendError: false,
          ));
        } on SocketException {
          emit(OtpStateAlert(
              alertTitle: 'Ошибка связи',
              alertContent: 'Проверьте интернет-соединение'));
          emit(OtpStateToRebuild(
            secondsLeft: secondsLeft,
            codeError: codeError,
            enteredCode: enteredCode,
            requestCodeButtonEnabled: requestCodeButtonEnabled,
            signUpButtonEnabled: signUpButtonEnabled,
            codeInputEnabled: true,
            codeSendError: false,
          ));
        } on TimeoutException {
          emit(OtpStateAlert(
              alertTitle: 'Ошибка связи',
              alertContent: 'Низкая скорость интернета'));
          emit(OtpStateToRebuild(
            secondsLeft: secondsLeft,
            codeError: codeError,
            enteredCode: enteredCode,
            requestCodeButtonEnabled: requestCodeButtonEnabled,
            signUpButtonEnabled: signUpButtonEnabled,
            codeInputEnabled: true,
            codeSendError: false,
          ));
        } catch (e) {
          emit(OtpStateAlert(
              alertTitle: 'Неизвестная ошибка',
              alertContent: 'Попробуйте позже'));
          emit(OtpStateToRebuild(
            secondsLeft: secondsLeft,
            codeError: codeError,
            enteredCode: enteredCode,
            requestCodeButtonEnabled: requestCodeButtonEnabled,
            signUpButtonEnabled: signUpButtonEnabled,
            codeInputEnabled: true,
            codeSendError: false,
          ));
        }
        break;

      case OtpVerificationError.Invalid:
        codeError = 'Неверный код';
        emit(OtpStateToRebuild(
          secondsLeft: secondsLeft,
          codeError: codeError,
          enteredCode: enteredCode,
          requestCodeButtonEnabled: requestCodeButtonEnabled,
          signUpButtonEnabled: signUpButtonEnabled,
          codeInputEnabled: true,
          codeSendError: false,
        ));
        break;

      case OtpVerificationError.ValidTimesUp:
        codeError = 'Код устарел';
        emit(OtpStateToRebuild(
          secondsLeft: secondsLeft,
          codeError: codeError,
          enteredCode: enteredCode,
          requestCodeButtonEnabled: requestCodeButtonEnabled,
          signUpButtonEnabled: signUpButtonEnabled,
          codeInputEnabled: true,
          codeSendError: false,
        ));
        break;

      default:
        codeError = 'Неизвестная ошибка';
        emit(OtpStateToRebuild(
          secondsLeft: secondsLeft,
          codeError: codeError,
          enteredCode: enteredCode,
          requestCodeButtonEnabled: requestCodeButtonEnabled,
          signUpButtonEnabled: signUpButtonEnabled,
          codeInputEnabled: true,
          codeSendError: false,
        ));
        break;
    }
  }
}
