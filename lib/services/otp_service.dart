import 'package:otp/otp.dart';

class OTPService {
  static const int otpRequestCooldown = 30;
  static const int OTPValidTimeInterval = 120;
  late String validOTP;
  late int CannotReqOTPUntilTime;
  late int OTPvalidUntilTime;

  String generateOTP() {
    validOTP = OTP.generateTOTPCodeString(
        OTP.randomSecret(), DateTime.now().microsecondsSinceEpoch,
        length: 4, interval: otpRequestCooldown);

    CannotReqOTPUntilTime =
        DateTime.fromMicrosecondsSinceEpoch(OTP.lastUsedTime)
            .add(Duration(seconds: otpRequestCooldown))
            .microsecondsSinceEpoch;

    OTPvalidUntilTime = DateTime.fromMicrosecondsSinceEpoch(OTP.lastUsedTime)
        .add(Duration(seconds: OTPValidTimeInterval))
        .microsecondsSinceEpoch;

    return validOTP;
  }

  bool canGenerateOTP() {
    if (OTP.lastUsedTime == 0)
      return true;
    else {
      if (OTP.lastUsedTime.compareTo(CannotReqOTPUntilTime) > 0) {
        return true;
      } else
        return false;
    }
  }

  OtpVerificationError verifyOTP(String otp) {
    // Если код ещё не генерировали, то проверять нечего.
    if (OTP.lastUsedTime == 0) return OtpVerificationError.None;

    // Истек срок валидности
    if (OTP.lastUsedTime.compareTo(OTPvalidUntilTime) > 0) return OtpVerificationError.ValidTimesUp;

    // Неверный код
    if (validOTP.compareTo(otp) != 0) return OtpVerificationError.Invalid;

    return OtpVerificationError.None;
  }
}

enum OtpVerificationError {None, ValidTimesUp, Invalid}