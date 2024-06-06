import 'package:feast_mobile_email/constraints.dart';
import 'package:feast_mobile_email/features/auth/otp_page/bloc/otp_bloc.dart';
import 'package:feast_mobile_email/features/auth/otp_page/widgets/otp_code_input.dart';
import 'package:feast_mobile_email/features/auth/otp_page/widgets/otp_email_label.dart';
import 'package:feast_mobile_email/features/auth/otp_page/widgets/otp_email_label_error.dart';
import 'package:feast_mobile_email/features/auth/otp_page/widgets/otp_request_code_button.dart';
import 'package:feast_mobile_email/features/auth/otp_page/widgets/otp_singup_button.dart';
import 'package:feast_mobile_email/models/user.dart';
import 'package:flutter/material.dart';

class OtpPageLayout extends StatefulWidget {
  final OtpStateToRebuild state;
  final User user;
  const OtpPageLayout(
      {super.key, required this.state, required this.user});

  @override
  State<OtpPageLayout> createState() => _OtpPageLayoutState();
}

class _OtpPageLayoutState extends State<OtpPageLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: authBackground,
      appBar: AppBar(
        backgroundColor: authBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
                widget.state.codeSendError
                    ? OtpEmailLabelError(email: widget.user.email)
                    : OtpEmailLabel(email: widget.user.email),
                SizedBox(height: 20),
                OtpCodeInput(errorText: widget.state.codeError),
                OtpRequestCodeButton(
                    secondsLeft: widget.state.secondsLeft),
                SizedBox(height: 50),
                OtpSignUpButton(enabled: widget.state.signUpButtonEnabled)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
