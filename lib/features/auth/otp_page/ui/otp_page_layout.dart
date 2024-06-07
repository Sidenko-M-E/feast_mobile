import 'package:feast_mobile_email/routes/routes.dart';
import 'package:feast_mobile_email/view_models/auth_view_model.dart';
import 'package:feast_mobile_email/view_models/otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/otp_code_input.dart';
import '../widgets/otp_email_label.dart';
import '../widgets/otp_email_label_error.dart';
import '../widgets/otp_request_code_button.dart';
import '../widgets/otp_singup_button.dart';

class OtpPageLayout extends StatelessWidget {
  const OtpPageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final otpVM = context.watch<OtpVM>();
    final authVM = context.watch<AuthVM>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            otpVM.stopTimer();
            goRouter.go('/profile/signup');
          },
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: <Widget>[
                Text('Введите код из почты ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 10),
                otpVM.codeSendError
                    ? OtpEmailLabelError(email: otpVM.user.email)
                    : OtpEmailLabel(email: otpVM.user.email),
                SizedBox(height: 20),
                OtpCodeInput(
                  enabled: !otpVM.codeSendError,
                  errorText: otpVM.codeError,
                  onCompleted: (p0) async {
                    if (await otpVM.verifyCode(p0)) {
                      debugPrint(authVM.user.accessToken);
                    }
                  },
                ),
                OtpRequestCodeButton(
                  secondsLeft: otpVM.secondsLeft,
                  onPressed: () {
                    if (otpVM.secondsLeft == 0) {
                      otpVM.requestNewCode();
                    }
                  },
                ),
                SizedBox(height: 50),
                OtpSignUpButton(
                    enabled: otpVM.signUpButtonEnabled,
                    onPressed: () {
                      debugPrint('Конпка нажатоа');
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
